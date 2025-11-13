return {
	{
		"tpope/vim-fugitive",

		config = function()
      -- vim.keymap.set("n", "<A-g>", ":tab G<cr>", { desc = "Git Status" })
      vim.keymap.set("n", "<A-g>", ":Neogit<cr>", { desc = "Git Status" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	},
	"sindrets/diffview.nvim",
}
