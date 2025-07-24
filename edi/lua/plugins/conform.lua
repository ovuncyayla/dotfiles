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
          -- rust = { "cargo_fix", lsp_format = "fallback" },
          yaml = { "yamlfmt" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        formatters = {
          cargo_fix = {
            command = "cargo",
            args = { "fix", "--allow-dirty" }
          }
        }
      })
      vim.keymap.set("n", "<leader>lf", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "vim.lsp.buf.format" })
    end,
  },
}
