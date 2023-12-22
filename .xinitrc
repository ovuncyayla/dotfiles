xset r rate 600 25 &
/usr/lib/at-spi-bus-launcher --launch-immediately &
/usr/bin/autorandr -c --default default &
/usr/bin/autorandr -c --default default &
/usr/lib/blueberry/blueberry-obex-agent.py &
blueberry-tray &
blueman-applet &
conky --daemonize --pause=1 &
/usr/bin/garuda-system-maintenance &
/usr/lib/geoclue-2.0/demos/agent &
/usr/bin/gnome-keyring-daemon --start --components=pkcs11 &
/usr/bin/gnome-keyring-daemon --start --components=secrets &
/usr/bin/gnome-keyring-daemon --start --components=ssh &
nm-applet &
onboard --not-show-in=GNOME,GNOME-Classic &
/usr/lib/evolution-data-server/evolution-alarm-notify &
/usr/lib/gsd-disk-utility-notify &
sh -c GDK_BACKEND=x11 pamac-tray &
sh -c GDK_BACKEND=x11 pamac-tray &
pasystray &
picom &
bash -c grep -q .snapshots /proc/cmdline && sleep 3 && snapper-tools --autostart &
/usr/lib/xapps/xapp-sn-watcher &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
sh -c systemctl --user start xfce4-notifyd.service 2>/dev/null || exec /usr/lib/xfce4/notifyd/xfce4-notifyd &
xfce4-power-manager &
xfce4-screensaver &
xfsettingsd &
sh -c xrandr --output HDMI-2 --mode 1920x1080 --rate 60.00 --output eDP-1 --mode 1920x1080 --rate 59.98 --left-of HDMI-2 &
flameshot &
/usr/bin/syncthingtray qt-widgets-gui --single-instance &
xfce4-clipman &
exec awesome
