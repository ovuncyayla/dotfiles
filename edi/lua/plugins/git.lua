return {
  {
  "tpope/vim-fugitive",

  config = function()
    vim.keymap.set("n", "<A-g>", ":tab G<cr>", { desc = "Git Status" })
  end
},
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",
}
