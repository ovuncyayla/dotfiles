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

-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]
-- require("indent_blankline").setup {
--     char = "",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     space_char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     show_trailing_blankline_indent = false,
-- }
--
require("which-key").setup({})

local notify = require('notify')
notify.setup({ stages = "slide" })
vim.notify = notify

require('neogit').setup {}
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('SetNoListGroup', { clear = true }),
  once = false,
  callback = function()
    vim.opt.list = false
  end,
  pattern="Neogit*Popup"
})

require("nvim-surround").setup({})

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

require("mini.align").setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    start = 'ga',
    start_with_preview = 'gA',
  },
})


require("telekasten").setup({
  home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
})
