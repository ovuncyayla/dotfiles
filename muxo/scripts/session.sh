#!/bin/bash

selection=$(fd --type=directory --hidden --exclude '**/node_modules/*' --follow --max-depth=7  --glob '**/.git'  ~/bookmarks/ | sed 's/.git\/$//' | fzf)

session_name=$(basename $selection)

if [[ -z "$TMUX" ]]; then
  [[ -z $selection ]] && echo "No selection" && exit 0
  tmux new-session -A -s $session_name -c $selection 
  exit 0
fi

if [[ -z $selection ]]; then
  # tmux display-message -d 300 'No selection!'
  exit 0
fi

if ! tmux has-session -t $session_name 2> /dev/null; then
  tmux new-session -d -s $session_name -c $selection 
fi

tmux switch-client -t $session_name

