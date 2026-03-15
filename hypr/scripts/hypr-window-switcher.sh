#!/bin/bash
# Get list of clients from hyprctl in JSON
clients_json=$(hyprctl clients -j)

# Create a clean list for rofi (Class: Title)
display_list=$(echo "$clients_json" | jq -r '.[] | "\(.class): \(.title)"')

# Use rofi to select, returning the index (0-based)
selection_index=$(echo "$display_list" | rofi -dmenu -p "window" -i -format 'i')

# If a selection was made (index is not empty)
if [ ! -z "$selection_index" ]; then
    # Get the address using the index
    address=$(echo "$clients_json" | jq -r ".[$selection_index].address")
    hyprctl dispatch focuswindow address:$address
fi
