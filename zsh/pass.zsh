#!/bin/zsh
# pass-activate / pass-deactivate / pass-active
#
# Ad-hoc bundle loading from `pass` into the current shell. Complements
# direnv (which owns per-directory env); use these for temporary overrides
# like "I want prod creds in this shell for the next 10 minutes" without
# editing an .envrc.
#
# Each .gpg file under <pass-path> is exported as an env var whose name is
# the filename (without .gpg). To override var names, use direnv/use_secret.

pass-activate() {
  emulate -L zsh
  setopt err_return pipe_fail

  local ppath="$1"
  if [[ -z "$ppath" ]]; then
    print -u2 "usage: pass-activate <pass-path>"
    return 1
  fi
  if ! command -v pass >/dev/null; then
    print -u2 "pass-activate: pass not installed"
    return 1
  fi

  local store="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
  local dir="$store/$ppath"
  if [[ ! -d "$dir" ]]; then
    print -u2 "pass-activate: no such pass path: $ppath"
    return 1
  fi

  local -a leaves
  leaves=("$dir"/*.gpg(N))
  if (( ${#leaves} == 0 )); then
    print -u2 "pass-activate: no secrets under: $ppath"
    return 1
  fi

  # Collect new values before touching the environment, so a failure
  # mid-loop doesn't leave a half-activated shell.
  local -A new_values
  local f var value
  for f in "${leaves[@]}"; do
    var="${${f:t}%.gpg}"
    if ! value=$(pass show "$ppath/$var" 2>/dev/null); then
      print -u2 "pass-activate: failed to decrypt $ppath/$var"
      return 1
    fi
    if [[ -z "$value" ]]; then
      print -u2 "pass-activate: empty secret at $ppath/$var"
      return 1
    fi
    new_values[$var]="$value"
  done

  # Clear whatever the previous activation exported, so we don't leak
  # stale vars from a different bundle (dev → prod switch case).
  pass-deactivate --quiet

  local -a activated
  for var in "${(@k)new_values}"; do
    typeset -gx "$var"="${new_values[$var]}"
    activated+=("$var")
  done

  typeset -gx PASS_ACTIVE="$ppath"
  typeset -gx PASS_ACTIVATED_VARS="${(j: :)activated}"
  print "activated: $ppath (${#activated} vars)"
}

pass-deactivate() {
  emulate -L zsh
  local quiet=0
  [[ "$1" == "--quiet" ]] && quiet=1

  if [[ -z "${PASS_ACTIVE:-}" ]]; then
    (( quiet )) || print "nothing active"
    return 0
  fi

  local var
  for var in ${=PASS_ACTIVATED_VARS}; do
    unset "$var"
  done
  local prev="$PASS_ACTIVE"
  unset PASS_ACTIVE PASS_ACTIVATED_VARS
  (( quiet )) || print "deactivated: $prev"
}

pass-active() {
  if [[ -z "${PASS_ACTIVE:-}" ]]; then
    print "nothing active"
    return 0
  fi
  print "path: $PASS_ACTIVE"
  print "vars: $PASS_ACTIVATED_VARS"
}

_pass-activate() {
  local store="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
  [[ -d "$store" ]] || return 1
  local -a dirs
  dirs=(${(f)"$(cd "$store" && find . -type d -not -path '*/.git*' -not -path '.' 2>/dev/null | sed 's|^\./||' | sort)"})
  _describe -t pass-dirs 'pass directory' dirs
}
compdef _pass-activate pass-activate
