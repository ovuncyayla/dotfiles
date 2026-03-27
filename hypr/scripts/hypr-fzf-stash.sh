#!/usr/bin/env bash
# hypr-fzf-stash.sh
# Stash all windows on current workspace to ws:20.

STASH_WS=20
ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id')

hyprctl clients -j | jq -r --argjson ws "$ACTIVE_WS" '
  .[] | select(.workspace.id == $ws) | .address
' | while read -r addr; do
  hyprctl dispatch movetoworkspacesilent "$STASH_WS,address:$addr"
done
