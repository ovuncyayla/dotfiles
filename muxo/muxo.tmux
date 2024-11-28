#!/bin/bash

tmux bind-key -n M-\\ run-shell "$TMUX_PLUGIN_MANAGER_PATH/muxo/invoke_script.sh 'project-session'"
tmux bind-key -n M-n run-shell "$TMUX_PLUGIN_MANAGER_PATH/muxo/invoke_script.sh 'file-manager'"
tmux bind-key -T prefix c run-shell "$TMUX_PLUGIN_MANAGER_PATH/muxo/invoke_script.sh 'new-window'"
tmux bind-key -T prefix C-x run-shell "$TMUX_PLUGIN_MANAGER_PATH/muxo/invoke_script.sh 'kill-sessions'"

