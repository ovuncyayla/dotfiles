local awful = require("awful")
-- Enable touchpad tap
awful.util.spawn('xinput set-prop "CUST0001:00 04F3:30AA Touchpad" "libinput Tapping Enabled" 1')
awful.util.spawn('ssh-agent')
awful.util.spawn('xfce4-power-manager')
