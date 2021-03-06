local opts = { noremap = true, silent = true }
-- local map = function(key, lhs, rhs, op)
--   local options = { table.unpack(op or {}), table.unpack(opts) }
--   return vim.keymap.set(key, lhs, rhs, options)
-- end
local map = vim.keymap.set

map("", "<Space>", "<Nop>") -- disable space because leader

vim.g.mapleader = " "

map("i", "jk", "<ESC>")

-- Normal --
-- Standard Operations
map("n", "<leader>.", "<cmd>cd %:p:h<cr>", { desc = "Set CWD" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
-- map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "No Highlight" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })
map("n", "Q", "<Nop>")

-- Packer
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer Compile" })
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer Install" })
map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer Sync" })
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer Status" })
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer Update" })

-- Alpha
-- map("n", "<leader>d", "<cmd>Alpha<cr>", { desc = "Alpha Dashboard" })

-- Bufdelete
map("n", "<leader>q", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
-- map("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Navigate buffers
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer tab" })
map("n", ">b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer tab right" })
map("n", "<b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer tab left" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Comment
map("n", "<leader>/", function()
  require("Comment.api").toggle_current_linewise()
end, { desc = "Comment line" })
map(
  "v",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
  { desc = "Toggle comment line" }
)

-- GitSigns
map("n", "<leader>gj", function()
  require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
map("n", "<leader>gk", function()
  require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
map("n", "<leader>gl", function()
  require("gitsigns").blame_line()
end, { desc = "View git blame" })
map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview git hunk" })
map("n", "<leader>gh", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset git hunk" })
map("n", "<leader>gr", function()
  require("gitsigns").reset_buffer()
end, { desc = "Reset git buffer" })
map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage git hunk" })
map("n", "<leader>gu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Unstage git hunk" })
map("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "View git diff" })

-- NeoTree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" })

-- Session Manager
-- map("n", "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>", { desc = "Load last session" })
-- map("n", "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>", { desc = "Save this session" })
-- map("n", "<leader>Sd", "<cmd>SessionManager! delete_session<cr>", { desc = "Delete session" })
-- map("n", "<leader>Sf", "<cmd>SessionManager! load_session<cr>", { desc = "Search sessions" })
-- map(
--   "n",
--   "<leader>S.",
--   "<cmd>SessionManager! load_current_dir_session<cr>",
--   { desc = "Load current directory session" }
-- )

-- LSP Installer
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
vim.keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "LSP installer" })

-- Smart Splits
-- Better window navigation
map("n", "<C-h>", function()
  require("smart-splits").move_cursor_left()
end, { desc = "Move to left split" })
map("n", "<C-j>", function()
  require("smart-splits").move_cursor_down()
end, { desc = "Move to below split" })
map("n", "<C-k>", function()
  require("smart-splits").move_cursor_up()
end, { desc = "Move to above split" })
map("n", "<C-l>", function()
  require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })

-- Resize with arrows
map("n", "<C-Up>", function()
  require("smart-splits").resize_up()
end, { desc = "Resize split up" })
map("n", "<C-Down>", function()
  require("smart-splits").resize_down()
end, { desc = "Resize split down" })
map("n", "<C-Left>", function()
  require("smart-splits").resize_left()
end, { desc = "Resize split left" })
map("n", "<C-Right>", function()
  require("smart-splits").resize_right()
end, { desc = "Resize split right" })
-- map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
-- map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
-- map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

-- SymbolsOutline
map("n", "<leader>lS", "<cmd>AerialToggle<cr>", { desc = "Symbols outline" })

-- Telescope
map("n", "<leader>fw", function()
  require("telescope.builtin").live_grep()
end, { desc = "Search words" })
map("n", "<leader>gt", function()
  require("telescope.builtin").git_status()
end, { desc = "Git status" })
map("n", "<leader>gb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Git branchs" })
map("n", "<leader>gc", function()
  require("telescope.builtin").git_commits()
end, { desc = "Git commits" })
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Search files" })
map("n", "<leader>fB", function()
  require("telescope.builtin").buffers()
end, { desc = "Search buffers" })
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Search help" })
map("n", "<leader>fm", function()
  require("telescope.builtin").marks()
end, { desc = "Search marks" })
map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Search history" })
map("n", "<leader>sb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Git branchs" })
map("n", "<leader>sh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Search help" })
map("n", "<leader>sm", function()
  require("telescope.builtin").man_pages()
end, { desc = "Search man" })
map("n", "<leader>sn", function()
  require("telescope").extensions.notify.notify()
end, { desc = "Search notifications" })
map("n", "<leader>sr", function()
  require("telescope.builtin").registers()
end, { desc = "Search registers" })
map("n", "<leader>sk", function()
  require("telescope.builtin").keymaps()
end, { desc = "Search keymaps" })
map("n", "<leader>sc", function()
  require("telescope.builtin").commands()
end, { desc = "Search commands" })
map("n", "<leader>ls", function()
  local aerial_avail, _ = pcall(require, "aerial")
  if aerial_avail then
    require("telescope").extensions.aerial.aerial()
  else
    require("telescope.builtin").lsp_document_symbols()
  end
end, { desc = "Search symbols" })
map("n", "<leader>lR", function()
  require("telescope.builtin").lsp_references()
end, { desc = "Search references" })
map("n", "<leader>lD", function()
  require("telescope.builtin").diagnostics()
end, { desc = "Search diagnostics" })
map("n", "<leader>fb", function()
  require("telescope").extensions.file_browser.file_browser()
end, { desc = "File browser" })
map("n", "<leader>fp", function()
  require("telescope").extensions.project.project()
end, { desc = "File browser" })

map("n", "<leader>fz", function()
  require("telescope").extensions.zoxide.list {}
end, { desc = "File browser" })
-- Stay in indent mode
map("v", "<", "<gv", { desc = "unindent line" })
map("v", ">", ">gv", { desc = "indent line" })

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
map("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
