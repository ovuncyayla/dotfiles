#!/usr/bin/env bash

# This script monitors battery level and AC adapter status, sending notifications for important power events.

# --- Configuration ---
LOW_BATTERY_THRESHOLD=20
CRITICAL_BATTERY_THRESHOLD=10

# --- State Variables ---
ac_previous_status=-1 # -1 to ensure first run logic works
battery_notified_low=false
battery_notified_critical=false

# --- Find Power Supplies ---
find_power_supply() {
    for power_supply in /sys/class/power_supply/*; do
        if [ -f "$power_supply/type" ]; then
            case "$(cat "$power_supply/type")" in
                "Mains")
                    AC_ADAPTER="$power_supply"
                    ;;
                "Battery")
                    BATTERY="$power_supply"
                    ;;
            esac
        fi
    done
    # Fallback for older systems
    if [ -z "$AC_ADAPTER" ]; then
        AC_ADAPTER=$(find /sys/class/power_supply/ -name 'AC*' | head -n 1)
    fi
    if [ -z "$BATTERY" ]; then
        BATTERY=$(find /sys/class/power_supply/ -name 'BAT*' | head -n 1)
    fi
}

find_power_supply

# --- Main Loop ---
while true; do
    # Check if power supply paths exist
    if [ -z "$AC_ADAPTER" ] || [ ! -f "$AC_ADAPTER/online" ] || [ -z "$BATTERY" ] || [ ! -f "$BATTERY/capacity" ]; then
        sleep 60 # Wait before retrying to find paths
        find_power_supply
        continue
    fi

    # --- Read Current Status ---
    ac_status=$(cat "$AC_ADAPTER/online")
    battery_level=$(cat "$BATTERY/capacity")
    battery_status=$(cat "$BATTERY/status")

    # 1. Check for AC adapter state change
    if [ "$ac_status" -ne "$ac_previous_status" ]; then
        if [ "$ac_status" -eq 1 ]; then
            notify-send "Charging" "AC adapter connected. Battery at ${battery_level}%." -i "ac-adapter" -u low
            # Reset battery notification flags when plugged in
            battery_notified_low=false
            battery_notified_critical=false
        else
            notify-send "On Battery" "AC adapter disconnected. Battery at ${battery_level}%." -i "battery" -u low
        fi
        ac_previous_status="$ac_status"
    fi

    # 2. Check for low/critical battery only when discharging
    if [ "$battery_status" = "Discharging" ]; then
        if [ "$battery_level" -le "$CRITICAL_BATTERY_THRESHOLD" ] && [ "$battery_notified_critical" = false ]; then
            notify-send "Critical Battery" "Plug in immediately! Battery at ${battery_level}%." -i "battery-empty" -u critical
            battery_notified_critical=true
        elif [ "$battery_level" -le "$LOW_BATTERY_THRESHOLD" ] && [ "$battery_notified_low" = false ]; then
            notify-send "Low Battery" "Battery at ${battery_level}%." -i "battery-low" -u normal
            battery_notified_low=true
        fi
    fi

    sleep 20 # Check every 20 seconds
done
