-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
-- transparent background
vim.o.termguicolors = true
vim.cmd("highlight Normal guibg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE")
