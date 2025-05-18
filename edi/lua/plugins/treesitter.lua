return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      -- "nvim-treesitter/nvim-treesitter-context",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },

    config = function()
      -- [[ Configure Treesitter ]]
      require("nvim-treesitter.configs").setup({

        sync_install = false,
        auto_install = false,
        ignore_install = {},
        modules = {},

        -- -- Add languages to be installed here that you want installed for treesitter
        -- ensure_installed = {
        --   "c",
        --   "cpp",
        --   "go",
        --   "lua",
        --   "bash",
        --   "python",
        --   "rust",
        --   "typescript",
        --   "tsx",
        --   "ron",
        --   "vim",
        --   "java",
        --   "javascript",
        --   "html",
        --   "markdown",
        --   "markdown_inline",
        --   "css",
        --   "json",
        --   "toml",
        --   "query",
        --   "org",
        --   "hurl",
        --   "yaml",
        --   "sql",
        --   "svelte",
        --   "zig",
        --   "php",
        -- },

        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { "python" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          lsp_interop = {
            enable = true,
            floating_preview_opts = { border = "shadow" },
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
        },
      })

      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })

      vim.treesitter.language.register("css", "postcss")

      vim.filetype.add({
        extension = {
          mdx = "markdown.mdx",
        },
      })
      -- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
      -- ft_to_parser.mdx = "markdown"
      vim.treesitter.language.register("tsx", { "mdx", "markdown.mdx" })
      -- vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
