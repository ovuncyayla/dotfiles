-- Configure Plugins
require("custom.options")
require("custom.keybindings")
require("custom.setup")
require("custom.telescope")
require("custom.lsp")
require("custom.treesitter")
require("custom.cmp")
require("custom.snip")
require("custom.hydra")
require("custom.dap")
require("custom.telekasten")

pcall(function() vim.fn.execute(":source " .. vim.fn.expand("~/nvim_private/init.lua")) end)

vim.notify("Reloaded")
