#!/bin/bash

export NNN_TMPFILE=$(mktemp)

nnn -a

selection=$(cat $NNN_TMPFILE | cut -d' ' -f2 | tr -d "'")
session_name=$(basename $selection)

# Things that should not happen
if [[ -z $selection ]] || [[ -z session_name ]]; then
  echo "No way" && exit 0
fi

if [[ $session_name == '/' ]]; then
  session_name='root'
fi

if [[ -z "$TMUX" ]]; then
  tmux new-session -A -s $session_name -c $selection 
  exit 0
fi

if ! tmux has-session -t $session_name 2> /dev/null; then
  tmux new-session -d -s $session_name -c $selection 
fi

tmux switch-client -t $session_name

