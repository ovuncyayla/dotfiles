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

require("luasnip.loaders.from_vscode").lazy_load()

require("which-key").setup({})

-- require('bufferline').setup({
--     options = {
--       offsets = {
--         { filetype = "NvimTree", text = "", padding = 1 },
--         { filetype = "neo-tree", text = "", padding = 1 },
--         { filetype = "Outline", text = "", padding = 1 },
--       },
--       buffer_close_icon = "",
--       modified_icon = "",
--       close_icon = "",
--       max_name_length = 14,
--       max_prefix_length = 13,
--       tab_size = 20,
--       separator_style = "thin",
--     },
--   })

local notify = require('notify')
notify.setup({ stages = "slide" })
vim.notify = notify

require('neogit').setup {}

require('legendary').setup({ lazy_nvim = { auto_register = true } })

