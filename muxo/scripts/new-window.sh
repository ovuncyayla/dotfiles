#!/bin/bash

# Check if VIRTUAL_ENV is set
if [ -n "$VIRTUAL_ENV" ]; then
    tmux new-window -c "#{pane_current_path}" "source $VIRTUAL_ENV/bin/activate"
else
    tmux new-window -c "#{pane_current_path}"
fi
