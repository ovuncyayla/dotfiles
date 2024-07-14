return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.align").setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          start = 'ga',
          start_with_preview = 'gA',
        },
      })


      require("mini.comment").setup()
      require("mini.cursorword").setup()
    end,
  },
}
