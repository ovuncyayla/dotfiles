-- See `:help vim.keymap.set()`
local map = vim.keymap.set

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("i", "jk", "<ESC>")

-- Remap for dealing with word wrap
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<leader>.", "<cmd>cd %:p:h<cr>", { desc = "Set CWD" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
--map("n", "<leader><leader>s", "<cmd>source %<cr>", { desc = "Source Current File" })

-- Navigate buffers
map("n", "<leader>q", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>n", "<cmd>new<cr>", { desc = "New buffer" })
map("n", "<leader>v", "<cmd>vnew<cr>", { desc = "New vertical buffer" })
map("n", "<leader>t", "<cmd>tabnew<cr>", { desc = "New tab buffer" })
map("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<S-h>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Telescope
map("n", "<leader>bb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>jk", { desc = "Search Files [B]rowser" })
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function() require('telescope.builtin').current_buffer_fuzzy_find() end,
  { desc = '[/] Fuzzily search in current buffer]' })
map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>FF', function() require('telescope.builtin').find_files({ hidden = true }) end,
  { desc = '[S]earch [F]iles +Hidden' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
-- map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sg', require('telescope').extensions.live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = 'Search [D]ocument [S]ymbols' })
map("n", "<leader>sn", function() require("telescope").extensions.notify.notify() end,
  { desc = "[S]earch [n]otifications" })
map("n", "<leader>sc", function() require("telescope.builtin").commands() end, { desc = "[S]earch [c]ommands" })
map("n", "<leader>sr", function() require("telescope.builtin").registers() end, { desc = "[S]earch [r]egisters" })
map("n", "<leader>sm", function() require("telescope.builtin").marks() end, { desc = "[S]earch [m]arks" })
map("n", "<leader>pp", function() require("telescope").extensions.project.project() end,
  { desc = "[P]rojectile find [P]roject" })

-- Lsp
map("n", "<leader>lt", "<cmd>TroubleToggle<cr>", { desc = "Trouble Toggle" })
map("n", "<leader>ln", "<cmd>AerialToggle<cr>", { desc = "Aerial Toggle" })

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
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    map('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    map('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    map('i', '<C-q>', vim.lsp.buf.signature_help, opts)

  end,
})
-- Git
map("n", "<A-g>", function() require("neogit").open({}) end, { desc = "NeoGit Status" })
-- LuaSnip
local ls = require("luasnip")
map({"i"}, "<C-k>", function() ls.expand() end, {silent = true})
map({"i", "s"}, "<C-l>", function() ls.jump( 1) end, {silent = true})
map({"i", "s"}, "<C-j>", function() ls.jump(-1) end, {silent = true})
map({"i", "s"}, "<C-e>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})


-- Legendary
map("n", "<leader><F12>", "<cmd>LegendaryScratchToggle<cr>", { desc = "Toggle Lua Scratch Buffer" })
map("n", "<A-x>", "<cmd>Legendary<cr>", { desc = "Toggle Lua Scratch Buffer" })
map("n", "<leader><leader>s", "<cmd>LegendaryEvalBuf<cr>", { desc = "Source Current File" })
map("n", "<leader><leader>l", "<cmd>LegendaryEvalLine<cr>", { desc = "Source Current Line" })
map("n", "<leader><leader>v", "<cmd>LegendaryEvalLines<cr>", { desc = "Source Visual Lines" })
