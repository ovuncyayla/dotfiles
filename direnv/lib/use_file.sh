#!/usr/bin/env bash
# File-backed secret helper for .envrc files.
#
# Usage in a project .envrc:
#   use_file KUBECONFIG infra/k3s/s3rv0-kubeconfig
#   use_file GOOGLE_APPLICATION_CREDENTIALS projects/foo/gcp-sa-json 600
#   use_file SSH_KEY personal/deploy-key 400
#
# Reads the value from `pass show <path>`, materializes it to a tmpfs-backed
# file under $XDG_RUNTIME_DIR, and exports $VAR pointing at that path. The
# file is rewritten on every direnv reload so rotations in pass take effect
# immediately. If $VAR is already set, it's left alone (parent .envrc wins).
#
# Fails the .envrc loudly if: pass is missing, the secret is empty, or the
# runtime dir is unavailable.
#
# Files are shared across projects by pass path, not per-project
# ------------------------------------------------------------------
# The on-disk filename is derived from the pass path alone (sha1 of it).
# So two different projects that reference the same pass entry end up
# pointing at the exact same tmpfs file — intentional, this is "one source
# of truth" for a given credential.
#
# The one edge case to be aware of: if Project A calls
#   use_file KUBECONFIG infra/k3s/s3rv0-kubeconfig 600
# and Project B later calls
#   use_file KUBECONFIG infra/k3s/s3rv0-kubeconfig 400
# the second chmod wins for both, because they're the same file.
# Rare in practice, and the fix (per-project subdirs) adds more
# complexity than it saves. If you hit it, split the pass entries
# instead of splitting the filesystem layout.

use_file() {
  local var="$1" path="$2" mode="${3:-600}"
  if [ -z "$var" ] || [ -z "$path" ]; then
    log_error "use_file: usage: use_file VAR_NAME pass/path [mode]"
    return 1
  fi
  if [ -n "${!var:-}" ]; then
    return 0
  fi
  if ! command -v pass >/dev/null; then
    log_error "use_file: pass not installed"
    return 1
  fi

  local runtime_dir="${XDG_RUNTIME_DIR:-}"
  if [ -z "$runtime_dir" ] || [ ! -d "$runtime_dir" ]; then
    log_error "use_file: \$XDG_RUNTIME_DIR not available — refusing to write secret to persistent storage"
    return 1
  fi

  local dir="$runtime_dir/direnv-files"
  mkdir -p "$dir"
  chmod 700 "$dir"

  local key file
  key=$(printf '%s' "$path" | sha1sum | cut -c1-40)
  file="$dir/$key"

  local value
  value=$(pass show "$path" 2>/dev/null)
  if [ -z "$value" ]; then
    log_error "use_file: no secret at pass path '$path'"
    return 1
  fi

  umask 077
  printf '%s' "$value" > "$file"
  chmod "$mode" "$file"

  export "$var=$file"
}
