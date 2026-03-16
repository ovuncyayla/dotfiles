#!/usr/bin/env bash

# Battery alert script for Hyprland/Waybar
# Requirements: libnotify (notify-send)

LOW_BATTERY_THRESHOLD=15
CRITICAL_BATTERY_THRESHOLD=5

while true; do
    # Get battery percentage and status
    # Assumes BAT0, change if your system uses BAT1 etc.
    BAT_PATH="/sys/class/power_supply/BAT0"
    if [ ! -d "$BAT_PATH" ]; then
        BAT_PATH="/sys/class/power_supply/BAT1"
    fi
    
    if [ -d "$BAT_PATH" ]; then
        capacity=$(cat "$BAT_PATH/capacity")
        status=$(cat "$BAT_PATH/status")

        if [ "$status" = "Discharging" ]; then
            if [ "$capacity" -le "$CRITICAL_BATTERY_THRESHOLD" ]; then
                notify-send -u critical "🪫 CRITICAL BATTERY" "Battery is at ${capacity}%! Plug in now!"
                sleep 60
            elif [ "$capacity" -le "$LOW_BATTERY_THRESHOLD" ]; then
                notify-send -u normal "🔋 Low Battery" "Battery is at ${capacity}%."
                sleep 300
            fi
        fi
    fi
    sleep 60
done
