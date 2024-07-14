local configure_telescope = function()
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require("telescope")
local actions = require("telescope.actions")
local fb_actions = telescope.extensions.file_browser.actions
-- local trouble = require("trouble.providers.telescope")

telescope.setup({
  defaults = {
    preview = {
      treesitter = false,
    },
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
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        -- ["<C-t>"] = require("trouble.sources.telescope").open(),
        ["<C-]>"] = actions.edit_command_line,
      },
      --
      n = {
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        -- ["<C-t>"] = require("trouble.sources.telescope").open(),
        ["<C-]>"] = actions.edit_command_line,
      },
    },
  },
  pickers = {},
  extensions = {
    file_browser = {
      use_fd = true,
      follow_symlinks = true,
      layout_strategy = "bottom_pane",
      mappings = {
        i = {
          ["<C-z>"] = fb_actions.toggle_hidden,
          ["<C-h>"] = fb_actions.goto_parent_dir,
          ["<C-l>"] = actions.select_default,
          ["<C-I>"] = fb_actions.toggle_respect_gitignore,
        },
        n = {
          Z = fb_actions.toggle_hidden,
          h = fb_actions.goto_parent_dir,
          l = actions.select_default,
          I = fb_actions.toggle_respect_gitignore,
        },
      },
    },
    dap = {},
    fzf = {
      fuzzy = true,                -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case",    -- or "ignore_case" or "respect_case"
    },
    media_files = {
      -- filetypes whitelist
      filetypes = { "png", "jpg", "jpeg", "mp4", "webp", "webm", "pdf" },
      find_cmd = "rg",
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("notify")
-- telescope.load_extension("aerial")
telescope.load_extension("file_browser")
-- telescope.load_extension("project")
-- telescope.load_extension("dap")
telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")
telescope.load_extension("media_files")

local map = vim.keymap.set
local findy = function(hidden)
  local tele = require("telescope.builtin")
  local ok, _ = pcall(tele.git_files, { show_untracked = hidden })
  if not ok then
    tele.find_files({ hidden = hidden })
  end
end

vim.keymap.set("n", "<Bslash>t", require("telescope.builtin").resume, { desc = "[T]elescope" })
map("n", "<leader>t", ":Telescope<CR>", { desc = "Resume Telescope" })

vim.keymap.set(
  "n",
  "<Bslash>b",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { desc = "Search Files [B]rowser" }
)
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })

-- vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set("n", "<Bslash><Bslash>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<Bslash>f", findy, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<Bslash>F", function()
  findy(true)
end, { desc = "[S]earch [F]iles +Hidden" })

vim.keymap.set("n", "<Bslash>h", require("telescope.builtin").help_tags, { desc = "[H]elp" })
vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })

vim.keymap.set(
  "n",
  "<Bslash>g",
  require("telescope").extensions.live_grep_args.live_grep_args,
  { desc = "[S]earch by [G]rep" }
)

-- vim.keymap.set("n", "<leader>pp", function() require("telescope").extensions.project.project() end,
--   { desc = "[P]rojectile find [P]roject" })

vim.keymap.set("n", "<leader>pf", function()
  findy(true)
end, { desc = "[P]roject Files" })

vim.keymap.set("n", "<Bslash>ee", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config"), hidden = true })
end, { desc = "Search [E]ditor Config" })

local cmd_find = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/**" }
vim.keymap.set("n", "<Bslash>ep", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("data"), find_command = cmd_find })
end, { desc = "Search [E]ditor [P]ugins" })
vim.keymap.set("n", "<Bslash>ed", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.expand("~/dotfiles"),
    find_command = cmd_find,
  })
end, { desc = "Search Dotfiles" })

vim.keymap.set("n", "<Bslash>ec", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.expand("~/.config"),
    find_command = cmd_find,
  })
end, { desc = "Search .config" })

vim.keymap.set("n", "<Bslash>eb", function()
  require("telescope").extensions.file_browser.file_browser({
    cwd = vim.fn.expand("~/dotfiles"),
    -- find_command = cmd_find
  })
end, { desc = "Search Dotfiles" })

-- TODO
map("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
map("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "[/] Fuzzily search in current buffer]" })
map("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "Search [D]ocument [S]ymbols" })
map("n", "<leader>sn", function()
  require("telescope").extensions.notify.notify()
end, { desc = "[S]earch [n]otifications" })
map("n", "<leader>sc", function()
  require("telescope.builtin").commands()
end, { desc = "[S]earch [c]ommands" })
map("n", "<A-x>", function()
  require("telescope.builtin").commands()
end, { desc = "[S]earch [c]ommands" })
map("n", "<leader>sr", function()
  require("telescope.builtin").registers()
end, { desc = "[S]earch [r]egisters" })
map("n", "<leader>sm", function()
  require("telescope.builtin").marks()
end, { desc = "[S]earch [m]arks" })
end

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      -- "nvim-telescope/telescope-dap.nvim",
      -- "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
    config = configure_telescope
  },
  { "junegunn/fzf" },
}

