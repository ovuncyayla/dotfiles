local map = vim.keymap.set
local bmap = function(mod, lhs, rhs, opts)
	opts = opts or {}
	opts["buffer"] = true
	map(mod, lhs, rhs, opts)
end

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("i", "jk", "<ESC>")

map("x", ">", ">gv")
map("x", "<", "<gv")

map("n", "<leader>.", "<cmd>cd %:p:h<cr>", { desc = "Set CWD" })
map("n", "<leader><leader>e", ":source " .. vim.fn.stdpath("config") .. "/init.lua<CR>", { desc = "Souce Editor Config" })
map("n", "<leader><leader>p",
	function()
		pcall(function() vim.fn.execute(":source " .. vim.fn.expand("~/nvim_private/init.lua")) end)
	end,
	{ desc = "Souce Private Config" })
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



vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('Quicky', {}),
	pattern = "qf",
	callback = function(ev)
		bmap("n", "q", ":q<CR>")
		bmap("n", "<C-j>", "j<CR><CMD>cope<CR>")
		bmap("n", "<C-k>", "k<CR><CMD>cope<CR>")
		bmap("n", "<C-o>", "<CR><CMD>cope<CR>")
		bmap("n", "<C-l>", "<CR><CMD>cope<CR>")
	end,
})
