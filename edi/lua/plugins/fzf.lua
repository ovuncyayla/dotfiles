return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          fullscreen = true,
        },
        -- keymap = {
        --   fzf = {
        --     ["C-d"] = "preview-page-down",
        --     ["C-u"]   = "preview-page-up",
        --   }
        -- }
      })

      vim.keymap.set("i", "<C-L>", require("fzf-lua").complete_line, { desc = "FzfLua complete_line" })

      vim.keymap.set("n", "<Bslash>fzf", ":FzfLua<CR>", { desc = "FzfLua" })

      vim.keymap.set("n", "<Bslash>fzr", ":FzfLua resume<CR>", { desc = "Resume FzfLua" })

      vim.keymap.set("n", "<leader>f?", ":FzfLua oldfiles<CR>", { desc = "[?] FzfLua oldfiles" })

      -- vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set("n", "<Bslash><Bslash>", ":FzfLua buffers<CR>", { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>/", ":FzfLua lgrep_curbuf<CR>", { desc = "[/] FzfLua lgrep_curbuf" })

      vim.keymap.set("n", "<Bslash>ff", ":FzfLua files<CR>", { desc = "FzfLua files" })
      -- vim.keymap.set("n", "<Bslash>F", function()
      --   findy(true)
      -- end, { desc = "[S]earch [F]iles +Hidden" })

      vim.keymap.set("n", "<Bslash>h", ":FzfLua helptags<CR>", { desc = "FzfLua helptags" })
      vim.keymap.set("n", "<leader>sk", ":FzfLua keymaps<CR>", { desc = "FzfLua keymaps" })

      vim.keymap.set("n", "<Bslash>gg", ":FzfLua live_grep<CR>", { desc = "FzfLua live_grep" })
      vim.keymap.set("n", "<Bslash>gw", ":FzfLua grep_cword<CR>", { desc = "FzfLua grep_cword" })
      vim.keymap.set("n", "<leader>gw", ":FzfLua grep_cWORD<CR>", { desc = "FzfLua grep_cWORD" })

      vim.keymap.set("n", "<Bslash>fe", function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config"), hidden = true })
      end, { desc = "Search [E]ditor Config" })

      vim.keymap.set("n", "<Bslash>fep", function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("data") })
      end, { desc = "FzfLua [E]ditor [P]ugins" })
      vim.keymap.set("n", "<Bslash>fd", function()
        require("fzf-lua").files({ cwd = vim.fn.expand("~/dotfiles") })
      end, { desc = "FzfLua files Dotfiles" })

      vim.keymap.set("n", "<Bslash>fec", function()
        require("fzf-lua").files({ cwd = vim.fn.expand("~/.config") })
      end, { desc = "Search .config" })

      vim.keymap.set("n", "<Bslash>z", function()
        require("fzf-lua").files({
          cwd = vim.fn.expand("~/zettelkasten"),
        })
      end, { desc = "Search Zettelkasten" })

      vim.keymap.set("n", "<Bslash>fb", function()
        require("fzf-lua").files({
          cwd = vim.fn.expand("~/bookmarks/projects"),
        })
      end, { desc = "Find in Projects" })

      vim.keymap.set(
        "n",
        "<leader>fd",
        require("fzf-lua").diagnostics_document,
        { desc = "FzfLua diagnostics_document" }
      )
      vim.keymap.set(
        "n",
        "<leader>fw",
        require("fzf-lua").diagnostics_workspace,
        { desc = "FzfLua diagnostics_document" }
      )
      vim.keymap.set(
        "n",
        "<leader>fsd",
        require("fzf-lua").lsp_document_symbols,
        { desc = "Search [D]ocument [S]ymbols" }
      )
      vim.keymap.set(
        "n",
        "<leader>fsw",
        require("fzf-lua").lsp_workspace_symbols,
        { desc = "Search [D]ocument [S]ymbols" }
      )
      vim.keymap.set("n", "<leader>fc", function()
        require("fzf-lua").commands()
      end, { desc = "[S]earch [c]ommands" })
      vim.keymap.set("n", "<leader>fr", function()
        require("fzf-lua").registers()
      end, { desc = "[S]earch [r]egisters" })
      vim.keymap.set("n", "<leader>fm", function()
        require("fzf-lua").marks()
      end, { desc = "[S]earch [m]arks" })

      vim.keymap.set("n", "<leader>sm", function()
        require("fzf-lua").manpages()
      end, { desc = "[S]earch [m]an pages" })

      vim.keymap.set("n", "<leader>sn", function()
        require("telescope").extensions.notify.notify()
      end, { desc = "[S]earch [n]otifications" })
    end,
  },
}
