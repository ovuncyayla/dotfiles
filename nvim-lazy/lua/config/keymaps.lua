-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>gv", ":DiffviewOpen<CR>", { desc = "Toggle DiffView" })

vim.keymap.set("n", "<A-J>", "m`_:y<CR> p==``", { desc = "Copy line down" })
vim.keymap.set("n", "<A-K>", "m`_:y<CR> P==``", { desc = "Copy line up" })
vim.keymap.set("i", "<A-J>", "<Esc>m`_:y<CR> p==``gi", { desc = "Copy line down" })
vim.keymap.set("i", "<A-K>", "<Esc>m`_:y<CR> P==``gi", { desc = "Copy line up" })
vim.keymap.set("v", "<A-J>", "_:'<,'>y<CR> '>p==gv=gv", { desc = "Copy selection down" })
vim.keymap.set("v", "<A-K>", "_:'<,'>y<CR> '<p==gv=gv", { desc = "Copy selection down" })
vim.keymap.set("x", "gss", ":<ESC>:'<,'>g/^/m '><cr>", { desc = "Reverse selected lines" })

vim.keymap.set(
  "n",
  "<Space><Space>s",
  "<cmd>luafile %<cr><cmd>lua vim.notify('Sourced: ' .. vim.fn.expand('%'))<cr>",
  { desc = "Source Current File" }
)
vim.keymap.set("v", "<Space><Space>s", ":lua<cr><cmd>lua vim.notify('Sourced visual')<cr>", { desc = "Source visual" })
