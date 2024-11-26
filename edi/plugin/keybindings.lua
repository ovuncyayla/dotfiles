local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader><leader>s", "<cmd>luafile %<cr><cmd>lua vim.notify('Sourced: ' .. vim.fn.expand('%'))<cr>", { desc = "Source Current File" })
map("v", "<leader><leader>s", ":lua<cr><cmd>lua vim.notify('Sourced visual')<cr>", { desc = "Source visual" })

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("i", "jk", "<ESC>")

map({"n", "v"}, "<leader>y", "\"+y", { desc = "Copy clipboard" })
map({"n", "v"}, "<leader>p", "\"+p", { desc = "Paste clipboard" })

map({"n", "v"}, "<leader>Y", "\"*y", { desc = "Copy selection" })
map({"n", "v"}, "<leader>P", "\"*p", { desc = "Paste selection" })

map("x", ">", ">gv")
map("x", "<", "<gv")

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

map("x", "gss", ":<ESC>:'<,'>g/^/m '><cr>", { desc = "Reverse selected lines" })

-- Navigate buffers
map("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>Q", "<cmd>bdelete!<cr>", { desc = "Close buffer" })
map("n", "<C-w><C-j>", "<cmd>new<cr>", { desc = "New buffer" })
map("n", "<C-w><C-l>", "<cmd>vnew<cr>", { desc = "New vertical buffer" })
map("n", "<C-j>", "<C-w>j", { desc = "Win down" })
map("n", "<C-k>", "<C-w>k", { desc = "Win up" })
map("n", "<C-h>", "<C-w>h", { desc = "Win left" })
map("n", "<C-l>", "<C-w>l", { desc = "Win right" })

local function exec_line()
  local line = vim.fn.getline(".")
  -- vim.cmd(":!" .. line)
  return ":!" .. line .. "<CR>"
end

vim.keymap.set("n", "<leader>0", exec_line , { expr = true })
vim.cmd([[ noremap <leader>t :%s/\r//g<CR> ]])

