local oil = require('oil')

local function oil_copy()
	local entry = oil.get_cursor_entry()
	local cur_dir = oil.get_current_dir()
	local entry_path = cur_dir .. entry.name
	vim.notify(entry_path)
	vim.fn.setreg("+", entry_path)
end

vim.keymap.set("n", "<leader>y", oil_copy, { desc = "Oil copy path", buffer = true })
