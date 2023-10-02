--require('legendary').setup({ lazy_nvim = { auto_register = true } })

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
require('lualine').setup {}

-- Enable Comment.nvim
require('Comment').setup()

require('ibl').setup {}

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

require("which-key").setup({})

local notify = require('notify')
notify.setup({ stages = "slide" })
vim.notify = notify

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

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("FE", { clear = true }),
  pattern = "*.postcss",
  callback = function(ev)
    -- vim.notify(vim.inspect(ev))
    vim.bo.filetype = "postcss"
  end
})
