return {
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-vinegar",
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	"anuvyklack/hydra.nvim",
	{
		"rcarriga/nvim-notify",
		configure = function()
			local notify = require("notify")
			-- notify.setup({ stages = "slide" })
			notify.setup()
			vim.notify = notify
		end,
	},

	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})

			local ft = require("Comment.ft")
			ft.set("typescriptreact", { "{/* %s */}", "{/* %s */}" })
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({ stages = "slide" })
			vim.notify = notify
		end,
	},

	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
    config = function ()
      vim.cmd [[colorscheme cyberdream ]]
    end
	},
}
