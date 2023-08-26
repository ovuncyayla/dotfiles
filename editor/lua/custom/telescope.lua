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
      hijack_netrw = true,
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
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    media_files = {
      -- filetypes whitelist
      filetypes = {"png", "jpg", "jpeg", "mp4", "webp", "webm", "pdf"},
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
