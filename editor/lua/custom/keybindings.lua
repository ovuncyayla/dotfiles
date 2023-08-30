local map = vim.keymap.set
local bmap = function (mod, lhs, rhs, opts)
	opts = opts or {}
	opts["buffer"] = true
	map(mod, lhs, rhs, opts)
end

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("i", "jk", "<ESC>")

map("x", ">", ">gv")
map("x", "<", "<gv")

-- Remap for dealing with word wrap
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<leader>.", "<cmd>cd %:p:h<cr>", { desc = "Set CWD" })
map("n", "<leader><leader>e", function()
	return ":source " .. vim.fn.stdpath("config") .. "/init.lua<CR>" end, { desc = "Souce Editor Config" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
--map("n", "<leader><leader>s", "<cmd>source %<cr>", { desc = "Source Current File" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

map("n", "<A-J>", "m`_:y<CR> p==``", { desc = "Copy line down" })
map("n", "<A-K>", "m`_:y<CR> P==``", { desc = "Copy line up" })
map("i", "<A-J>", "<Esc>m`_:y<CR> p==``gi", { desc = "Copy line down" })
map("i", "<A-K>", "<Esc>m`_:y<CR> P==``gi", { desc = "Copy line up" })
map("v", "<A-J>", "_:'<,'>y<CR> '>p==gv=gv", { desc = "Copy selection down" })
map("v", "<A-K>", "_:'<,'>y<CR> '<p==gv=gv", { desc = "Copy selection down" })

-- Navigate buffers
map("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<C-w><C-j>", "<cmd>new<cr>", { desc = "New buffer" })
map("n", "<C-w><C-l>", "<cmd>vnew<cr>", { desc = "New vertical buffer" })
map("n", "<C-j>", "<C-w>j", { desc = "Win down" })
map("n", "<C-k>", "<C-w>k", { desc = "Win up" })
map("n", "<C-h>", "<C-w>h", { desc = "Win left" })
map("n", "<C-l>", "<C-w>l", { desc = "Win right" })
map("n", "<C-w>t", "<cmd>tabnew<cr>", { desc = "New tab buffer" })
map("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<S-h>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Lsp
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		map('n', '<leader>lD', vim.lsp.buf.declaration, opts)
		map('n', '<leader>ld', vim.lsp.buf.definition, opts)
		map('n', '<leader>L', vim.lsp.buf.hover, opts)
		map('n', '<leader>li', vim.lsp.buf.implementation, opts)
		map('n', '<C-l>', vim.lsp.buf.signature_help, opts)
		map('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, opts)
		map('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, opts)
		map('n', '<leader>lwl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		map('n', '<leader>lk', vim.lsp.buf.type_definition, opts)
		map('n', '<leader>ln', vim.lsp.buf.rename, opts)
		map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		map('n', '<leader>lr', vim.lsp.buf.references, opts)
		map('n', '<leader>lf', function()
			vim.lsp.buf.format { async = true }
		end, opts)

		map("n", "<leader>lt", "<cmd>TroubleToggle<cr>", { desc = "Trouble Toggle" })
		map("n", "<leader>ln", "<cmd>AerialToggle<cr>", { desc = "Aerial Toggle" })

		map('i', '<C-q>', vim.lsp.buf.signature_help, opts)

	end,
})
-- Git
map("n", "<A-g>", function() require("neogit").open({}) end, { desc = "NeoGit Status" })
-- LuaSnip
local ls = require("luasnip")
-- map({ "i" }, "<C-k>", function() ls.expand() end, { silent = true })
map({ "i", "s" }, "<C-l>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, { silent = true })
map({ "i", "s" }, "<C-k>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })


vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('Quicky', {}),
	pattern = "qf",
	callback = function(ev)
		map("n", "<C-j>", "j<CR><CMD>cope<CR>")
		map("n", "<C-k>", "k<CR><CMD>cope<CR>")
		map("n", "<C-o>", "<CR><CMD>cope<CR>")
		map("n", "<C-l>", "<CR><CMD>cope<CR>")
	end,
})

-- Legendary
map("n", "<leader><leader>s", "<cmd>LegendaryEvalBuf<cr>", { desc = "Source Current File" })
map("n", "<leader><leader>l", "<cmd>LegendaryEvalLine<cr>", { desc = "Source Current Line" })
map("n", "<leader><leader>v", "<cmd>LegendaryEvalLines<cr>", { desc = "Source Visual Lines" })

