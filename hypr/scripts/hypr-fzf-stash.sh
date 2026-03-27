#!/usr/bin/env bash
# hypr-fzf-stash.sh
# Called with --keep-focused: stash all windows on current workspace except the focused one.
# Called without args: stash all windows on current workspace.

STASH_WS=20
ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$1" = "--keep-focused" ]; then
  FOCUSED_ADDR=$(hyprctl activewindow -j | jq -r '.address // empty')
  hyprctl clients -j | jq -r --argjson ws "$ACTIVE_WS" --arg keep "$FOCUSED_ADDR" '
    .[] | select(.workspace.id == $ws and .address != $keep) | .address
  ' | while read -r addr; do
    hyprctl dispatch movetoworkspacesilent "$STASH_WS,address:$addr"
  done
else
  hyprctl clients -j | jq -r --argjson ws "$ACTIVE_WS" '
    .[] | select(.workspace.id == $ws) | .address
  ' | while read -r addr; do
    hyprctl dispatch movetoworkspacesilent "$STASH_WS,address:$addr"
  done
fi
