return {
  -- Neogit - Magit-like git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<A-g>", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
  },

  -- Gitsigns - Git decorations
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  -- Diffview - Diff and merge tool
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = {},
  },
}
