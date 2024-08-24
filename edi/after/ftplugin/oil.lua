local oil = require('oil')
local fzf = require('fzf-lua')

local function oil_copy()
	local entry = oil.get_cursor_entry()
	local cur_dir = oil.get_current_dir()
	local entry_path = cur_dir .. entry.name
	vim.notify(entry_path)
	vim.fn.setreg("+", entry_path)
end

local function oil_files()
	local cur_dir = oil.get_current_dir()
  fzf.files({ cwd = cur_dir })
end

local function oil_grep()
	local cur_dir = oil.get_current_dir()
  fzf.live_grep({ cwd = cur_dir })
end

vim.keymap.set("n", "<leader>y", oil_copy, { desc = "Oil copy path", buffer = true })
vim.keymap.set("n", "f.", oil_files, { desc = "Oil files", buffer = true })
vim.keymap.set("n", "g.", oil_grep, { desc = "Oil files", buffer = true })
