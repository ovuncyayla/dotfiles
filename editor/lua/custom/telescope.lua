-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require('telescope')
local actions = require "telescope.actions"
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
  defaults = {
    hidden = true,
    prompt_prefix = " ",
    selection_caret = "❯ ",
    path_display = { "truncate" },
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        -- preview_width = 0.55,
        -- results_width = 0.8,
      },
      -- vertical = {
      --   mirror = false,
      -- },
      -- width = 0.87,
      -- height = 0.70,
      -- preview_cutoff = 120,
    },
    --
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        --
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        --
        --       ["<C-c>"] = actions.close,
        --
        --       ["<Down>"] = actions.move_selection_next,
        --       ["<Up>"] = actions.move_selection_previous,
        --
        --       ["<CR>"] = actions.select_default,
        --       ["<C-x>"] = actions.select_horizontal,
        --       ["<C-v>"] = actions.select_vertical,
        --       ["<C-t>"] = actions.select_tab,
        --
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        --
        --       ["<PageUp>"] = actions.results_scrolling_up,
        --       ["<PageDown>"] = actions.results_scrolling_down,
        --
        --       ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        --       ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        --       ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        --       ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        --       ["<C-l>"] = actions.complete_tag,
      },
      --
      n = {
        --       ["<esc>"] = actions.close,
        --       ["<CR>"] = actions.select_default,
        --       ["<C-x>"] = actions.select_horizontal,
        --       ["<C-v>"] = actions.select_vertical,
        --       ["<C-t>"] = actions.select_tab,
        --
        --       ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        --       ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        --       ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        --       ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        --
        --       ["j"] = actions.move_selection_next,
        --       ["k"] = actions.move_selection_previous,
        --       ["H"] = actions.move_to_top,
        --       ["M"] = actions.move_to_middle,
        --       ["L"] = actions.move_to_bottom,
        --
        --       ["<Down>"] = actions.move_selection_next,
        --       ["<Up>"] = actions.move_selection_previous,
        --       ["gg"] = actions.move_to_top,
        --       ["G"] = actions.move_to_bottom,
        --
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        --       ["<PageUp>"] = actions.results_scrolling_up,
        --       ["<PageDown>"] = actions.results_scrolling_down,
      },
    },
  },
  pickers = {},
  extensions = {
    file_browser = {
      use_fd = true,
      mappings = {
        i = {
          ["<S-z>"] = fb_actions.toggle_hidden,
          ["<C-h>"] = fb_actions.goto_parent_dir,
          ["<C-l>"] = actions.select_default,
        },
        n = {
          Z = fb_actions.toggle_hidden,
          h = fb_actions.goto_parent_dir,
          l = actions.select_default,
        },
      },
    },
    dap = {},
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    media_files = {
      -- filetypes whitelist
      filetypes = { "png", "jpg", "jpeg", "mp4", "webp", "webm", "pdf" },
      find_cmd = "rg"
    }
  },
})

telescope.load_extension('fzf')
telescope.load_extension("notify")
telescope.load_extension("aerial")
telescope.load_extension("file_browser")
telescope.load_extension("project")
telescope.load_extension("dap")
telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")
telescope.load_extension('media_files')

local map = vim.keymap.set
local findy = function(hidden)
  local tele = require('telescope.builtin')
  local ok, _ = pcall(tele.git_files, { show_untracked = hidden })
  if not ok then
    tele.find_files({ hidden = hidden })
  end
end

vim.keymap.set("n", "<Bslash>t", ":Telescope<CR>", { desc = "[T]elescope" })
vim.keymap.set("n", "<Bslash>b", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { desc = "Search Files [B]rowser" })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })

vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function() require('telescope.builtin').current_buffer_fuzzy_find() end,
  { desc = '[/] Fuzzily search in current buffer]' })


vim.keymap.set('n', '<Bslash>f', findy, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<Bslash>F', function() findy(true) end, { desc = '[S]earch [F]iles +Hidden' })

vim.keymap.set('n', '<Bslash>h', require('telescope.builtin').help_tags, { desc = '[H]elp' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })

vim.keymap.set('n', '<Bslash>g', require('telescope').extensions.live_grep_args.live_grep_args,
  { desc = '[S]earch by [G]rep' })


vim.keymap.set("n", "<leader>pp", function() require("telescope").extensions.project.project() end,
  { desc = "[P]rojectile find [P]roject" })

vim.keymap.set('n', '<Bslash>ee',
  function() require('telescope.builtin').find_files({ cwd = vim.fn.stdpath("config"), hidden = true }) end,
  { desc = 'Search [E]ditor Config' })

local cmd_find = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/**" }
vim.keymap.set('n', '<Bslash>ep',
  function() require('telescope.builtin').find_files({ cwd = vim.fn.stdpath("data"), find_command = cmd_find }) end,
  { desc = 'Search [E]ditor [P]ugins' })
vim.keymap.set('n', '<Bslash>ed',
  function() require('telescope.builtin').find_files({ cwd = vim.fn.expand("~/dotfiles"),
    find_command = cmd_find }) end,
  { desc = 'Search Dotfiles' })

vim.keymap.set('n', '<Bslash>ec',
  function() require('telescope.builtin').find_files({ cwd = vim.fn.expand("~/.config"),
    find_command = cmd_find }) end,
  { desc = 'Search .config' })

-- TODO
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader>/', function() require('telescope.builtin').current_buffer_fuzzy_find() end,
  { desc = '[/] Fuzzily search in current buffer]' })
map('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = 'Search [D]ocument [S]ymbols' })
map("n", "<leader>sn", function() require("telescope").extensions.notify.notify() end,
  { desc = "[S]earch [n]otifications" })
map("n", "<leader>sc", function() require("telescope.builtin").commands() end, { desc = "[S]earch [c]ommands" })
map("n", "<A-x>", function() require("telescope.builtin").commands() end, { desc = "[S]earch [c]ommands" })
map("n", "<leader>sr", function() require("telescope.builtin").registers() end, { desc = "[S]earch [r]egisters" })
map("n", "<leader>sm", function() require("telescope.builtin").marks() end, { desc = "[S]earch [m]arks" })


-- vim.api.nvim_create_autocmd("FileType", {
--   group = vim.api.nvim_create_augroup("TeleGru", { clear = true }),
--   pattern = "TelescopePrompt",
--   callback = function(ev)
--     vim.notify("TeleGru")
--     map("i", "<Esc>", "<Esc><Esc>", { buffer = true })
--   end
-- })
