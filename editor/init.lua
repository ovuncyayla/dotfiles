-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
  "LunarVim/darkplus.nvim",
  { 'folke/tokyonight.nvim', lazy = false },

  -- Icons
  "kyazdani42/nvim-web-devicons",

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
  { 'NeogitOrg/neogit', dependencies = 'nvim-lua/plenary.nvim' },


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
    dependencies = "kyazdani42/nvim-web-devicons",
    event = "LspAttach",
    keys = {
      { "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" }
    }
  },

  -- Dap Configuration
  { 'mfussenegger/nvim-dap', dependencies = { 'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text' } },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets' },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
      -- Additional text objects via treesitter
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    }
  },


  'nvim-lualine/lualine.nvim', -- Fancier statusline
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  'anuvyklack/hydra.nvim',

  -- Notification Enhancer
  "rcarriga/nvim-notify",

  -- Keymaps popup
  "folke/which-key.nvim",

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-dap.nvim',
    'nvim-telescope/telescope-project.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  }
  },

  "akinsho/toggleterm.nvim",

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },

  'nvim-orgmode/orgmode',
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
require("custom.terminal")
require("custom.hydra")
require("custom.dap")
