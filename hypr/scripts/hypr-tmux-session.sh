#!/usr/bin/env bash
# hypr-tmux-session.sh
# Launch or attach to a tmux session via fzf, from outside tmux (Hyprland keybind).
# If a window for the session already exists, focus it instead of spawning a new one.

printf '\033]0;ghostty-tmux\007'

selection=$(fd --type=directory --hidden --no-ignore \
  --exclude '**/node_modules/*' \
  --follow --max-depth=7 \
  --glob '**/.git' \
  ~/bookmarks/ \
  | sed 's/\.git//' \
  | sed 's/\/\/$/\//' \
  | fzf \
    --prompt="  session > " \
    --header="Enter: attach/create session" \
    --height=100% \
    --border=none \
    --info=inline \
    --color="bg:#0e101a,bg+:#1a1c2e,fg:#ebefc0,fg+:#ebefc0,hl:#00b4e0,hl+:#00b4e0,prompt:#00b4e0,pointer:#5dcd97,header:#444860")

[ -z "$selection" ] && exit 0

session_name=$(basename "$selection" | tr '.' '_' | tr ':' '_')
win_title="tmux-$session_name"

# Check if a window with this session's title already exists
existing=$(hyprctl clients -j | jq -r --arg t "$win_title" '.[] | select(.initialTitle == $t) | .address' | head -1)

if [ -n "$existing" ]; then
  ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id')
  hyprctl dispatch movetoworkspace "$ACTIVE_WS,address:$existing"
  hyprctl dispatch focuswindow "address:$existing"
elif tmux has-session -t "$session_name" 2>/dev/null; then
  hyprctl dispatch exec "ghostty --title=$win_title -e tmux attach-session -t $session_name"
else
  hyprctl dispatch exec "ghostty --title=$win_title -e tmux new-session -s $session_name -c $selection"
fi
