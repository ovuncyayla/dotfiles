#!/bin/bash

TMUX_PLUGIN_MANAGER_PATH=${TMUX_PLUGIN_MANAGER_PATH:~/.tmux/plugins}

tmux bind-key -n M-\\ run-shell "$TMUX_PLUGIN_MANAGER_PATH/muxo/invoke_script.sh 'project-session'"
tmux bind-key -T prefix c run-shell "$TMUX_PLUGIN_MANAGER_PATH/muxo/invoke_script.sh 'new-window'"
tmux bind-key -T prefix C-x run-shell "$TMUX_PLUGIN_MANAGER_PATH/muxo/invoke_script.sh 'kill-sessions'"

