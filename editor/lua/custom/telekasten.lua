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

vim.api.nvim_create_autocmd('BufAdd', {
	group = vim.api.nvim_create_augroup('Zettelkasten', {}),
	pattern = "zettelkasten/*",
	callback = function(ev)
		bmap("n", "f", ":lua require('telekasten').find_notes()<CR>")
		bmap("n", "d", ":lua require('telekasten').find_daily_notes()<CR>")
		bmap("n", "g", ":lua require('telekasten').search_notes()<CR>")
		bmap("n", "l", ":lua require('telekasten').follow_link()<CR>")
		bmap("n", "T", ":lua require('telekasten').goto_today()<CR>")
		bmap("n", "W", ":lua require('telekasten').goto_thisweek()<CR>")
		bmap("n", "w", ":lua require('telekasten').find_weekly_notes()<CR>")
		bmap("n", "n", ":lua require('telekasten').new_note()<CR>")
		bmap("n", "N", ":lua require('telekasten').new_templated_note()<CR>")
		bmap("n", "y", ":lua require('telekasten').yank_notelink()<CR>")
		bmap("n", "c", ":lua require('telekasten').show_calendar()<CR>")
		bmap("n", "C", ":CalendarT<CR>")
		bmap("n", "i", ":lua require('telekasten').paste_img_and_link()<CR>")
		bmap("n", "t", ":lua require('telekasten').toggle_todo()<CR>")
		bmap("n", "b", ":lua require('telekasten').show_backlinks()<CR>")
		bmap("n", "F", ":lua require('telekasten').find_friends()<CR>")
		bmap("n", "I", ":lua require('telekasten').insert_img_link({ i=true })<CR>")
		bmap("n", "p", ":lua require('telekasten').preview_img()<CR>")
		bmap("n", "m", ":lua require('telekasten').browse_media()<CR>")
		bmap("n", "a", ":lua require('telekasten').show_tags()<CR>")
		bmap("n", "#", ":lua require('telekasten').show_tags()<CR>")
		bmap("n", "r", ":lua require('telekasten').rename_note()<CR>")
	end,
})
