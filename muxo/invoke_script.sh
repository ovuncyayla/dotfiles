#!/bin/bash

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
  *)
    tmux display-message -d 500 'Not an option!'
    ;;
esac
