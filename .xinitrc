#!/bin/env bash

# Accesibility daemon
/usr/lib/at-spi-bus-launcher --launch-immediately &

# Display stuff
# sh -c xrandr --output HDMI-2 --mode 1920x1080 --rate 60.00 --output eDP-1 --mode 1920x1080 --rate 59.98 --left-of HDMI-2 &
/usr/bin/autorandr -c --default default &
[[ -e ~/.screenlayout/default.sh ]] && . ~/.screenlayout/default.sh &

/usr/bin/gnome-keyring-daemon --start --components=ssh,secrets,pkcs11 &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# /usr/bin/garuda-system-maintenance &
# /usr/lib/geoclue-2.0/demos/agent &
# onboard --not-show-in=GNOME,GNOME-Classic &
# /usr/lib/evolution-data-server/evolution-alarm-notify &
/usr/lib/gsd-disk-utility-notify &

# Notification Daemon
# sh -c systemctl --user start xfce4-notifyd.service 2>/dev/null || exec /usr/lib/xfce4/notifyd/xfce4-notifyd &
dunst &

# Systray
/usr/lib/xapps/xapp-sn-watcher &

nm-applet &

pasystray &

# xfdesktop &
# xfce4-power-manager &
# xfce4-screensaver &
# xfsettingsd &
# light-locker --no-idle-hint --lock-on-suspend --lock-on-lid --lock-after-screensaver=30 &
xscreensaver --no-splash &

sh -c GDK_BACKEND=x11 pamac-tray &

#/usr/lib/blueberry/blueberry-obex-agent.py &
blueman-applet &
# blueberry-tray &

/usr/bin/syncthingtray qt-widgets-gui --single-instance &

flameshot &

#xfce4-clipman &
copyq &

picom &

nitrogen --restore &

xset r rate 600 25 &

# exec awesome
dbus-launch --sh-syntax --exit-with-session awesome
