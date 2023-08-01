require('legendary').setup({ lazy_nvim = { auto_register = true } })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require("luasnip.loaders.from_vscode").lazy_load({})

require("which-key").setup({})

local notify = require('notify')
notify.setup({ stages = "slide" })
vim.notify = notify

require('neogit').setup {}

require("nvim-surround").setup({})

require('orgmode').setup_ts_grammar()
require('orgmode').setup({
  org_agenda_files = { '~/org/*' },
  org_default_notes_file = '~/org/notes.org',
})

require("stickybuf").setup()
require("aerial").setup({
  backends = {
      ['_']  = {"lsp", "treesitter", "markdown", "man"},
      -- python = {"treesitter"},
      -- rust   = {"lsp"},
  },
  filter_kind = false,
  layout = {
    resize_to_content = false,
    max_width = { 40, math.floor(vim.o.columns * 0.25) },
    min_width = math.floor(vim.o.columns * 0.25),
  }
})
