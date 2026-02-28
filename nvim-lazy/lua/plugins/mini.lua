return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.surround").setup()
      require("mini.align").setup({
        -- module mappings. use `''` (empty string) to disable one.
        mappings = {
          start = "ga",
          start_with_preview = "ga",
        },
      })
    end,
  },
}
