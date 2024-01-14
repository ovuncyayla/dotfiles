#!/bin/sh
#xrandr --output eDP-1 --mode 1366x768 --pos 1920x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal
xrandr --output eDP-1 --fb 1920x1080 --scale-from 1920x1080 --mode 1366x768 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --scale 1x1 --mode 1920x1080 --pos 0x0 --rotate normal --same-as eDP-1
