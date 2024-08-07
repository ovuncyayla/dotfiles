local servers = {
	clangd = {},
	cmake = {},
	-- gopls = {},
	-- pyright = {},
	jedi_language_server = {},
	rust_analyzer = {},
	jsonls = {},
	tsserver = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"markdown.mdx",
		},
	},
	svelte = {},
	tailwindcss = {},
	cssls = {},
	jdtls = {
		require("custom.jdtls"),
	},
	angularls = {},
	eslint = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	-- stylua = {},
	bashls = {},
	intelephense = {

		stubs = {
			"bcmath",
			"bz2",
			"calendar",
			"Core",
			"curl",
			"zip",
			"zlib",
			"wordpress",
			"woocommerce",
			"acf-pro",
			"wordpress-globals",
			"wp-cli",
			"genesis",
			"polylang",
		},

		phpactor = {},
		phpstan = {},
		phpmd = {},
		phpcs = {},
		phpcbf = {},
		["php-cs-fixer"] = {},
	},

	dockerls = {},

	sqlls = {},
	marksman = {
		filetypes = { "markdown", "markdown.mdx", "mdx" },
	},
	mdx_analyzer = {
		filetypes = { "markdown", "markdown.mdx", "mdx" },
	},
	html = {},
}

local on_attach = function(_, bufnr)
	pcall(vim.lsp.inlay_hint, bufnr, true)

	local map = vim.keymap.set

	local lsp_attach_buf_to_active_client = function()
		local clies = {}
		for i, v in ipairs(vim.lsp.get_active_clients()) do
			clies[i] = { v.id, v.name }
		end

		vim.ui.select(clies, {
			prompt = "Select a client to attach",
			format_item = function(item)
				return item[2]
			end,
		}, function(cli)
			vim.notify("Attaching to client: " .. cli[2])
			vim.lsp.buf_attach_client(0, cli[1])
		end)
	end

	local opts = { buffer = bufnr }
	local withDesc = function(desc)
		local options = opts
		options["desc"] = desc
		return options
	end

	map("n", "<leader>lD", vim.lsp.buf.declaration, withDesc("vim.lsp.buf.declaration"))
	map("n", "<leader>ld", vim.lsp.buf.definition, withDesc("vim.lsp.buf.definition"))
	map("n", "<leader>li", vim.lsp.buf.implementation, withDesc("vim.lsp.buf.implementation"))
	map("n", "<leader>lk", vim.lsp.buf.type_definition, withDesc("vim.lsp.buf.type_definition"))
	map("n", "<leader>lr", vim.lsp.buf.references, withDesc("vim.lsp.buf.references"))

	map("n", "<leader>lds", require("telescope.builtin").lsp_document_symbols, withDesc("lsp_document_symbols,"))
	map(
		"n",
		"<leader>lws",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		withDesc("lsp_dynamic_workspace_symbols")
	)

	map("n", "<C-q>", vim.lsp.buf.signature_help, withDesc("vim.lsp.buf.signature_help"))
	map("i", "<C-q>", vim.lsp.buf.signature_help, opts)
	map("n", "K", vim.lsp.buf.hover, withDesc("vim.lsp.buf.hover"))

	map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, withDesc("vim.lsp.buf.add_workspace_folder"))
	map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, withDesc("vim.lsp.buf.remove_workspace_folder"))
	map("n", "<leader>lwl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, withDesc("vim.lsp.buf.list_workspace_folders"))

	map("n", "<leader>ln", vim.lsp.buf.rename, withDesc("vim.lsp.buf.rename"))
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, withDesc("vim.lsp.buf.code_action"))

	-- map('n', '<leader>lf', function()
	--   vim.lsp.buf.format { async = true }
	-- end, withDesc("vim.lsp.buf.format"))

	map("n", "<leader>lf", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, withDesc("vim.lsp.buf.format"))

	map("n", "]d", vim.diagnostic.goto_next, withDesc("vim.lsp.buf.references"))
	map("n", "[d", vim.diagnostic.goto_prev, withDesc("vim.lsp.buf.references"))

	map("n", "<leader>lC", "<cmd>TSContextToggle<cr>", withDesc("TSContextToggle"))
	map("n", "<leader>lt", "<cmd>TroubleToggle<cr>", { desc = "Trouble Toggle" })
	map("n", "<leader>lwd", function() require("trouble").toggle("workspace_diagnostics") end)
	map("n", "<leader>ldd", function() require("trouble").toggle("document_diagnostics") end)
	map("n", "<leader>la", "<cmd>AerialToggle<cr>", { desc = "Aerial Toggle" })

	map("n", "<F4>", lsp_attach_buf_to_active_client, { desc = "Select an active client to attach" })
end

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	-- ensureinstalled = ensure_installed,
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- Turn on lsp status information
require("fidget").setup({})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh,bash,zsh",
	callback = function()
		vim.lsp.start({
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
		})
	end,
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.prettierd,
		-- null_ls.builtins.diagnostics.checkmake,
	},
})
