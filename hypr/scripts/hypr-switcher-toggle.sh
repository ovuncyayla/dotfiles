#!/usr/bin/env bash
# hypr-switcher-toggle.sh
# Toggles the fuzzy window switcher popup.

PICKER_TITLE="ghostty-fzf"

# Check if picker is already open (match by title since --class doesn't work on Wayland)
PICKER_ADDR=$(hyprctl clients -j | jq -r \
  --arg t "$PICKER_TITLE" \
  '.[] | select(.initialTitle == $t) | .address' | head -1)

if [ -n "$PICKER_ADDR" ]; then
  hyprctl dispatch closewindow "address:$PICKER_ADDR"
else
  ghostty --title="$PICKER_TITLE" -e ~/dotfiles/hypr/scripts/hypr-fzf-switcher.sh
fi
