-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if os.getenv('NVIM_MINIMAL') then
  require('custom.options')
  require('custom.minimal')
  return
end

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

  'navarasu/onedark.nvim', -- Theme inspired by Atom
  'LunarVim/darkplus.nvim',
  'rebelot/kanagawa.nvim',
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'folke/tokyonight.nvim', lazy = false },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = false },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  { 'projekt0n/github-nvim-theme' },

  -- Icons
  "nvim-tree/nvim-web-devicons",

  {
    'mrjones2014/legendary.nvim',
    version = 'v2.1.0',
    --priority = 10000
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = "legacy", event = "LspAttach" },
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  },

  {
    "folke/lsp-trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "LspAttach",
  },

  -- Dap Configuration
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text' }
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'rafamadriz/friendly-snippets' },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
      -- Additional text objects via treesitter
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',
      'JoosepAlviste/nvim-ts-context-commentstring',
    }
  },

  'nvim-lualine/lualine.nvim', -- Fancier statusline
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  'anuvyklack/hydra.nvim',

  -- Notification Enhancer
  "rcarriga/nvim-notify",

  -- Keymaps popup
  "folke/which-key.nvim",

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      'nvim-telescope/telescope-symbols.nvim'
    }
  },

  { 'junegunn/fzf' },

  'stevearc/aerial.nvim',
  { 'stevearc/overseer.nvim', opts = {}, },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },

  'imsnif/kdl.vim', -- Syntax and indent files for KDL
  { 'echasnovski/mini.align', version = '*' },

  {
    'renerocksai/telekasten.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'renerocksai/calendar-vim',
    }
  },

  -- Sql stuff
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      "kristijanhusak/vim-dadbod-ui",
    }
  },
  { 'mbbill/undotree' },

  'tpope/vim-vinegar',

  -- Local Plugins
  { dir = "~/dotfiles/blug", lazy = false },

}, {})

-- Configure Plugins
require("custom.options")
require("custom.keybindings")
require("custom.setup")
require("custom.telescope")
require("custom.lsp")
require("custom.treesitter")
require("custom.cmp")
require("custom.snip")
require("custom.hydra")
require("custom.dap")
require("custom.telekasten")

pcall(function() vim.fn.execute(":source " .. vim.fn.expand("~/nvim_private/init.lua")) end)
