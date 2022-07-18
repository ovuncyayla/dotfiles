local awful = require("awful")
-- Enable touchpad tap
awful.util.spawn('xinput set-prop "CUST0001:00 04F3:30AA Touchpad" "libinput Tapping Enabled" 1')
