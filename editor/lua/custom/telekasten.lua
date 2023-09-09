local map = vim.keymap.set
local bmap = function (mod, lhs, rhs, opts)
	opts = opts or {}
	opts["buffer"] = true
	vim.keymap.set(mod, lhs, rhs, opts)
end


local home = vim.fn.expand("~/zettelkasten")

require("telekasten").setup({
  home = home,

  dailies      = home .. '/' .. 'daily',
  weeklies     = home .. '/' .. 'weekly',
  templates    = home .. '/' .. 'templates',

})

map("n", "<leader>z", "<cmd>Telekasten panel<CR>")
map("n", "<Bslash>z", ":lua require('telekasten').find_notes()<CR>")
vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('Zettelkasten', {}),
	pattern = "*zettelkasten/*",
	callback = function(ev)
		-- bmap("n", "f", ":lua require('telekasten').find_notes()<CR>")
		bmap("n", "<leader>d", ":lua require('telekasten').find_daily_notes()<CR>")
		bmap("n", "<leader>g", ":lua require('telekasten').search_notes()<CR>")
		bmap("n", "<leader>zl", ":lua require('telekasten').follow_link()<CR>")
		bmap("n", "<leader>T", ":lua require('telekasten').goto_today()<CR>")
		bmap("n", "<leader>ZW", ":lua require('telekasten').goto_thisweek()<CR>")
		bmap("n", "<leader>zw", ":lua require('telekasten').find_weekly_notes()<CR>")
		bmap("n", "<leader>n", ":lua require('telekasten').new_note()<CR>")
		bmap("n", "<leader>N", ":lua require('telekasten').new_templated_note()<CR>")
		bmap("n", "<leader>zy", ":lua require('telekasten').yank_notelink()<CR>")
		bmap("n", "<leader>zc", ":lua require('telekasten').show_calendar()<CR>")
		bmap("n", "<leader>ZC", ":CalendarT<CR>")
		bmap("n", "<leader>zi", ":lua require('telekasten').paste_img_and_link()<CR>")
		bmap("n", "<leader><Tab>", ":lua require('telekasten').toggle_todo()<CR>")
		bmap("n", "<leader>zb", ":lua require('telekasten').show_backlinks()<CR>")
		bmap("n", "<leader>zf", ":lua require('telekasten').find_friends()<CR>")
		bmap("n", "<leader>zI", ":lua require('telekasten').insert_img_link({ i=true })<CR>")
		bmap("n", "<leader>zp", ":lua require('telekasten').preview_img()<CR>")
		bmap("n", "<leader>zm", ":lua require('telekasten').browse_media()<CR>")
		-- bmap("n", "<leader>a", ":lua require('telekasten').show_tags()<CR>")
		bmap("n", "<leader>#", ":lua require('telekasten').show_tags()<CR>")
		bmap("n", "<leader>zr", ":lua require('telekasten').rename_note()<CR>")
	end,
})
