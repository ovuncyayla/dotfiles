#!/usr/bin/env bash
# hypr-fzf-switcher.sh
# Fuzzy window switcher using fzf (multi-select).
# Run inside a floating terminal via Super+O.
# Brings selected window(s) to current workspace, stashes all others to ws:20.

STASH_WS=20
ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id')
LIST_FILE=$(mktemp /tmp/hypr-switcher-XXXXXX)

# Build window list, excluding the picker terminal itself
hyprctl clients -j | jq -r '
  .[] | select(.initialTitle != "ghostty-fzf") |
  "\(.class): \(.title)  [ws:\(.workspace.id)]  [addr:\(.address)]"
' > "$LIST_FILE"

if [ ! -s "$LIST_FILE" ]; then
  rm -f "$LIST_FILE"
  exit 0
fi

# Show picker with fzf (multi-select via Tab/Shift-Tab)
SELECTION=$(fzf \
  --multi \
  --prompt="  window > " \
  --header="Tab: select  Enter: confirm" \
  --height=100% \
  --border=none \
  --info=inline \
  --color="bg:#0e101a,bg+:#1a1c2e,fg:#ebefc0,fg+:#ebefc0,hl:#00b4e0,hl+:#00b4e0,prompt:#00b4e0,pointer:#5dcd97,header:#444860" \
  < "$LIST_FILE")

rm -f "$LIST_FILE"
[ -z "$SELECTION" ] && exit 0

# Collect all selected addresses
mapfile -t SELECTED_ADDRS < <(echo "$SELECTION" | grep -oP '\[addr:\K[^\]]+')
[ ${#SELECTED_ADDRS[@]} -eq 0 ] && exit 0

# Build a newline-separated list of selected addresses for jq filtering
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
