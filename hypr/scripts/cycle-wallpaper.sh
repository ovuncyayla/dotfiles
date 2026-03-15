#!/usr/bin/env bash

# Cycle wallpapers via hyprpaper
WALLS=(
    "/usr/share/hypr/wall0.png"
    "/usr/share/hypr/wall1.png"
    "/usr/share/hypr/wall2.png"
    "/home/nic3king/walpaper/line_neon_curved_182984_2560x1600.jpg"
)

# Use a temp file to track the current index
CACHE="/tmp/hyprpaper_index"
INDEX=$(cat "$CACHE" 2>/dev/null || echo 0)

# Calculate next index
NEXT=$(((INDEX + 1) % ${#WALLS[@]}))
echo $NEXT > "$CACHE"

# Apply via hyprctl
hyprctl hyprpaper wallpaper ",${WALLS[$NEXT]}"
