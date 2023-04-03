-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("i", "jk", "<ESC>")

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<leader>.", "<cmd>cd %:p:h<cr>", { desc = "Set CWD" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader><leader>s", "<cmd>source %<cr>", { desc = "Source Current File" })

-- Navigate buffers
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer tab" })
map("n", ">b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer tab right" })
map("n", "<b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer tab left" })
map("n", "<leader>q", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
-- map("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Telescope
map("n", "<leader>sb", function() require("telescope").extensions.file_browser.file_browser() end, { desc = "[S]earch Files [B]rowser" })
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>FF', function () require('telescope.builtin').find_files({ hidden = true }) end,{ desc = '[S]earch [F]iles +Hidden' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>SG', function () require('telescope.builtin').live_grep({word_match='-w'}) end , { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
map("n", "<leader>sn", function() require("telescope").extensions.notify.notify() end, { desc = "[S]earch [n]otifications" })
map("n", "<leader>sc", function() require("telescope.builtin").commands() end, { desc = "[S]earch [c]ommands" })
map("n", "<leader>sr", function() require("telescope.builtin").registers() end, { desc = "[S]earch [r]egisters" })
map("n", "<leader>sm", function() require("telescope.builtin").marks() end, { desc = "[S]earch [m]arks" })


map("n", "<leader>pp", function() require("telescope").extensions.project.project() end, { desc = "[P]rojectile find [P]roject" })
