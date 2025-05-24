#!/bin/bash

TMUX_PLUGIN_MANAGER_PATH=${TMUX_PLUGIN_MANAGER_PATH:~}

case $1 in 
  'project-session')
    tmux split-pane "source $TMUX_PLUGIN_MANAGER_PATH/muxo/scripts/session.sh"
    ;;
  'file-manager')
    tmux split-pane "source $TMUX_PLUGIN_MANAGER_PATH/muxo/scripts/filemanager.sh"
    ;;
  'new-window')
    tmux neww -e VIRTUAL_ENV=$VIRTUAL_ENV
    #"source $TMUX_PLUGIN_MANAGER_PATH/muxo/scripts/new_window.sh"
    ;;
  'kill-sessions')
    tmux split-pane "source $TMUX_PLUGIN_MANAGER_PATH/muxo/scripts/kill-sessions.sh"
    ;;
  *)
    tmux display-message -d 500 'Not an option!'
    ;;
esac
