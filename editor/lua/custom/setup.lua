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

require('lualine').setup {
  winbar = {},
  -- inactive_winbar = {
  --   lualine_a = {'filename'},
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {'filetype'},
  --   lualine_z = {'progress', 'location'}
  -- },

  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'FugitiveStatusline', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 2}, 'quickfix' },
    lualine_x = { 'overseer', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },

  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = { 'FugitiveStatusline' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = { 'progress', 'location' }
  },

  extensions = { 'fugitive', 'quickfix', 'overseer' }
}

-- Enable Comment.nvim
require('Comment').setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

local ft = require('Comment.ft')
ft.set('typescriptreact', { '{/* %s */}', '{/* %s */}' })

require("ibl").setup({ scope = { enabled = false } })

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

require("aerial").setup({
  backends = {
    ['_'] = { "lsp", "treesitter", "markdown", "man" },
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

require('overseer').setup()

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

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("SyntaxFold", { clear = true }),
  pattern = "gitcommit,git",
  callback = function(ev)
    vim.wo.foldmethod = 'syntax'
    vim.keymap.set('n', '<Tab>', 'za', { desc = "Toggle fold under cursor", buffer = true })
    vim.keymap.set('n', '=', 'za', { desc = "Toggle fold under cursor", buffer = true })
  end
})

