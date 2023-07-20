local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

{
    'mrjones2014/legendary.nvim',
    version = 'v2.1.0',
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },


{ -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  },

{ -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

{ -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

{ -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  },

  -- Git related plugins
{ 'NeogitOrg/neogit', dependencies = 'nvim-lua/plenary.nvim' },
'tpope/vim-fugitive',
'tpope/vim-rhubarb',
'lewis6991/gitsigns.nvim',

'navarasu/onedark.nvim', -- Theme inspired by Atom
"LunarVim/darkplus.nvim",
{ 'folke/tokyonight.nvim', lazy=false },
'nvim-lualine/lualine.nvim', -- Fancier statusline
'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Smarter Splits
"mrjones2014/smart-splits.nvim",

  -- Icons
"kyazdani42/nvim-web-devicons",

-- Bufferline
--"akinsho/bufferline.nvim"

  -- Better buffer closing
"famiu/bufdelete.nvim",

  -- Notification Enhancer
"rcarriga/nvim-notify",

  -- Keymaps popup
"folke/which-key.nvim",

'mfussenegger/nvim-jdtls',

  -- Fuzzy Finder (files, lsp, etc)
{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
"nvim-telescope/telescope-file-browser.nvim",
"nvim-telescope/telescope-dap.nvim",
"nvim-telescope/telescope-packer.nvim",
"nvim-telescope/telescope-project.nvim",
'nvim-telescope/telescope-ui-select.nvim',
"cljoly/telescope-repo.nvim",
"jvgrootveld/telescope-zoxide",
{ "francoiscabrol/ranger.vim", requires = { "rbgrouleff/bclose.vim" } },

"akinsho/toggleterm.nvim",

}, {})

-- Configure Plugins
require("custom.options")
require("custom.keybindings")
require("custom.setup")
require("custom.telescope")
require("custom.lsp")
require("custom.treesitter")
require("custom.cmp")
require("custom.java")
require("custom.terminal")
