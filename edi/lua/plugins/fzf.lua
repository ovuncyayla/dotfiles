return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({})

			vim.keymap.set("n", "<Bslash>fzf", ":FzfLua<CR>", { desc = "FzfLua" })

			vim.keymap.set("n", "<Bslash>fzr", ":FzfLua resume<CR>", { desc = "Resume FzfLua" })

			vim.keymap.set(
				"n",
				"<Bslash>b",
				":Telescope file_browser path=%:p:h select_buffer=true<CR>",
				{ desc = "Search Files [B]rowser" }
			)

			vim.keymap.set("n", "<leader>f?", ":FzfLua oldfiles<CR>", { desc = "[?] FzfLua oldfiles" })

			-- vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
			vim.keymap.set("n", "<Bslash><Bslash>", ":FzfLua buffers<CR>", { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>/", ":FzfLua lgrep_curbuf<CR>", { desc = "[/] FzfLua lgrep_curbuf" })

			vim.keymap.set("n", "<Bslash>ff", ":FzfLua files<CR>", { desc = "FzfLua files" })
			-- vim.keymap.set("n", "<Bslash>F", function()
			--   findy(true)
			-- end, { desc = "[S]earch [F]iles +Hidden" })

			vim.keymap.set("n", "<Bslash>h", ":FzfLua helptags<CR>", { desc = "FzfLua helptags" })
			vim.keymap.set("n", "<leader>sk", ":FzfLua keymaps<CR>", { desc = "FzfLua keymaps" })

			vim.keymap.set("n", "<Bslash>g", ":FzfLua live_grep<CR>", { desc = "FzfLua live_grep" })

			-- vim.keymap.set("n", "<leader>pp", function() require("telescope").extensions.project.project() end,
			--   { desc = "[P]rojectile find [P]roject" })

			-- vim.keymap.set("n", "<leader>pf", function() findy(true) end, { desc = "[P]roject Files" })

			vim.keymap.set("n", "<Bslash>fe", function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config"), hidden = true })
			end, { desc = "Search [E]ditor Config" })

			local cmd_find = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/**" }
			vim.keymap.set("n", "<Bslash>fep", function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("data"), find_command = cmd_find })
			end, { desc = "FzfLua [E]ditor [P]ugins" })
			vim.keymap.set("n", "<Bslash>fd", function() require("fzf-lua").files({ cwd = vim.fn.expand("~/dotfiles"), find_command = cmd_find, })
			end, { desc = "FzfLua files Dotfiles" })

			vim.keymap.set("n", "<Bslash>fec", function()
				require("fzf-lua").files({ cwd = vim.fn.expand("~/.config"), find_command = cmd_find,
				})
			end, { desc = "Search .config" })

			-- vim.keymap.set("n", "<Bslash>eb", function()
			--   require("telescope").extensions.file_browser.file_browser({
			--     cwd = vim.fn.expand("~/dotfiles"),
			--     -- find_command = cmd_find
			--   })
			-- end, { desc = "FzfLua Dotfiles" })

			vim.keymap.set("n", "<Bslash>z", function()
				require("fzf-lua").files({
					cwd = vim.fn.expand("~/zettelkasten"),
					find_command = cmd_find,
				})
			end, { desc = "Search Zettelkasten" })

			local map = vim.keymap.set
			-- TODO
			map("n", "<leader>fd", require("fzf-lua").diagnostics_document, { desc = "FzfLua diagnostics_document" })
			map("n", "<leader>fw", require("fzf-lua").diagnostics_workspace, { desc = "FzfLua diagnostics_document" })
			map("n", "<leader>fsd", require("fzf-lua").lsp_document_symbols, { desc = "Search [D]ocument [S]ymbols" })
			map("n", "<leader>fsw", require("fzf-lua").lsp_workspace_symbols, { desc = "Search [D]ocument [S]ymbols" })
			map("n", "<leader>sn", function()
				require("telescope").extensions.notify.notify()
			end, { desc = "[S]earch [n]otifications" })
			map("n", "<leader>fc", function()
				require("fzf-lua").commands()
			end, { desc = "[S]earch [c]ommands" })
			map("n", "<leader>fr", function()
				require("fzf-lua").registers()
			end, { desc = "[S]earch [r]egisters" })
			map("n", "<leader>fm", function()
				require("fzf-lua").marks()
			end, { desc = "[S]earch [m]arks" })
		end,
	},
}
