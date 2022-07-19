-- Theme handling library
local beautiful = require("beautiful")

local chosen_theme = 'default'
-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
-- beautiful.init(os.getenv('HOME') .. ".config/awsesome/themes/default/theme.lua")
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
