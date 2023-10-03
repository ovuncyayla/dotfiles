#!/bin/bash

case $1 in 
  'project-session')
    tmux split-pane "source $TMUX_PLUGIN_MANAGER_PATH/muxo/scripts/session.sh"
    ;;
  'file-manager')
    tmux split-pane "source $TMUX_PLUGIN_MANAGER_PATH/muxo/scripts/filemanager.sh"
    ;;
  *)
    tmux display-message -d 500 'Not an option!'
    ;;
esac
