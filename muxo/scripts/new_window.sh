#!/bin/bash

# # Check if VIRTUAL_ENV is set
# if [ -n "$VIRTUAL_ENV" ]; then
#     #tmux new-window -c "#{pane_current_path}" "source $VIRTUAL_ENV/bin/activate && $SHELL"
#     tmux new-window -c "#{pane_current_path}" "if [ -f #{pane_current_path}/env/bin/activate ]; then source  #{pane_current_path}/env/bin/activate; fi && $SHELL"
#     #"source $VIRTUAL_ENV/bin/activate && $SHELL"
#     #source "/bin/bash"
# else
#     #tmux new-window -c "#{pane_current_path}"
# fi
tmux display-message "if [ -f #{pane_current_path}/env/bin/activate ]; then source  #{pane_current_path}/env/bin/activate; fi && $SHELL"
tmux new-window -c "#{pane_current_path}" "if [ -f #{pane_current_path}/env/bin/activate ]; then source  #{pane_current_path}/env/bin/activate; fi && $SHELL"
