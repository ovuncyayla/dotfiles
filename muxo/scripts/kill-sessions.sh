#!/bin/bash

selection=$(tmux list-sessions | fzf -m | cut -d':' -f1)

if [[ -z $selection ]]; then
  exit 0
fi

echo $selection | xargs -n1 tmux kill-session -t

