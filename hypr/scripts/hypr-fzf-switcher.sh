#!/usr/bin/env bash
# hypr-window-switcher.sh
# Window switcher using fzf (multi-select).
# Brings selected window(s) to current workspace, stashes all others to ws:20.

STASH_WS=20
ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id')

# Set terminal title explicitly (prevent zsh from overwriting it)
printf '\033]0;ghostty-fzf\007'

# Format: "addr\tclass: title  [ws:N]" — addr is field 1 (hidden), rest is displayed
CLIENTS_LIST=$(hyprctl clients -j | jq -r '
  .[] | select(.initialTitle != "ghostty-fzf") |
  (.class | split(".") | last) as $cls |
  "\(.address)\t\($cls): \(.title)  [ws:\(.workspace.id)]"
')

[ -z "$CLIENTS_LIST" ] && exit 0

SELECTION=$(echo "$CLIENTS_LIST" | fzf \
  --multi \
  --with-nth=2.. \
  --delimiter='\t' \
  --prompt="  window > " \
  --header="Tab: select  Enter: confirm" \
  --height=100% \
  --border=none \
  --info=inline \
  --color="bg:#0e101a,bg+:#1a1c2e,fg:#ebefc0,fg+:#ebefc0,hl:#00b4e0,hl+:#00b4e0,prompt:#00b4e0,pointer:#5dcd97,header:#444860")

[ -z "$SELECTION" ] && exit 0

mapfile -t SELECTED_ADDRS < <(echo "$SELECTION" | cut -f1)
[ ${#SELECTED_ADDRS[@]} -eq 0 ] && exit 0

ADDR_LIST=$(printf '%s\n' "${SELECTED_ADDRS[@]}" | jq -Rn '[inputs]')

# Stash all windows on active workspace that are NOT selected
hyprctl clients -j | jq -r --argjson ws "$ACTIVE_WS" --argjson keep "$ADDR_LIST" '
  .[] | select(
    .workspace.id == $ws and
    ((.address | IN($keep[])) | not) and
    .initialTitle != "ghostty-fzf"
  ) | .address
' | while read -r win_addr; do
  hyprctl dispatch movetoworkspacesilent "$STASH_WS,address:$win_addr"
done

# Bring all selected windows to active workspace, focus the last one
for addr in "${SELECTED_ADDRS[@]}"; do
  hyprctl dispatch movetoworkspace "$ACTIVE_WS,address:$addr"
done
hyprctl dispatch focuswindow "address:${SELECTED_ADDRS[-1]}"
