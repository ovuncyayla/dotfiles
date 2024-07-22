return {
	"nvim-lualine/lualine.nvim", -- Fancier statusline
	config = {
		options = {
			theme = "auto",
		},
		winbar = {},
		-- inactive_winbar = {
		--   lualine_a = {'filename'},
		--   lualine_b = {},
		--   lualine_c = {},
		--   lualine_x = {},
		--   lualine_y = {'filetype'},
		--   lualine_z = {'progress', 'location'}
		-- },

		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "FugitiveStatusline", "diff", "diagnostics" },
			lualine_c = { { "filename", path = 2 }, "quickfix" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},

		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = { "FugitiveStatusline" },
			lualine_c = {},
			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = { "progress", "location" },
		},

		extensions = { "fugitive", "quickfix" },
	},
}
