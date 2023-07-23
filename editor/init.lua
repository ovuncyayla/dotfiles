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
    lazy = false,
    -- event = "Lsp*"
    keys = {
      { "<leader>t", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" }
    }
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets' },
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

  { 'nvim-treesitter/playground', after = 'nvim-treesitter', },

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

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-dap.nvim",
  "nvim-telescope/telescope-project.nvim",
  'nvim-telescope/telescope-ui-select.nvim',

  { "francoiscabrol/ranger.vim", lazy = false, dependencies = { "rbgrouleff/bclose.vim" },
    keys = { "<leader>f", "<cmd>Ranger<cr>", desc = "Ranger File Manager" } },

  "akinsho/toggleterm.nvim",

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },

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
