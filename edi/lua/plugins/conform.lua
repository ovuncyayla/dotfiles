return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua --indent-type spaces" },
          bash = { "shfmt" },
          sh = { "shfmt" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        -- formatters = {
        --   custom_lua = {
        --     command = "stylua",
        --     args = { "--indent-type", "tabs" }
        --   }
        -- }
      })
      vim.keymap.set("n", "<leader>lf", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "vim.lsp.buf.format" })
    end,
  },
}
