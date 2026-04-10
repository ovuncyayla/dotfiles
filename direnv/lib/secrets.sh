#!/usr/bin/env bash
# Secret helpers for .envrc files.
#
# Usage in a project .envrc:
#   use_secret GITHUB_TOKEN personal/github-token
#   use_secret DATABASE_URL projects/api-gateway/staging/DATABASE_URL
#
# Reads the value from `pass show <path>`. Only exports if the var is not
# already set, so a parent .envrc or outer shell can override. Fails the
# .envrc loudly if the secret is missing, so you notice instead of silently
# running with an empty credential.

use_secret() {
  local var="$1" path="$2"
  if [ -z "$var" ] || [ -z "$path" ]; then
    log_error "use_secret: usage: use_secret VAR_NAME pass/path"
    return 1
  fi
  if [ -n "${!var:-}" ]; then
    return 0
  fi
  if ! command -v pass >/dev/null; then
    log_error "use_secret: pass not installed"
    return 1
  fi
  local value
  value=$(pass show "$path" 2>/dev/null)
  if [ -z "$value" ]; then
    log_error "use_secret: no secret at pass path '$path'"
    return 1
  fi
  export "$var=$value"
}
