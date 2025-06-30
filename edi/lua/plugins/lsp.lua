local configure = function()
  local servers = {
    clangd                  = {},
    asm_lsp                 = {},
    -- cmake = {},
    arduino_language_server = {},
    -- gopls = {},
    -- pyright = {},
    jedi_language_server    = {},
    rust_analyzer           = {},
    gopls                   = {},
    jsonls                  = {},
    ts_ls                   = {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "markdown.mdx",
      },
    },
    svelte                  = {},
    tailwindcss             = {},
    cssls                   = {},
    -- jdtls = {
    --  require("custom.jdtls"),
    -- },
    angularls               = {},
    eslint                  = {},
    lua_ls                  = {
      -- Lua = {
      --   workspace = {
      --     checkThirdParty = false,
      --     library = {
      --       vim.env.VIMRUNTIME,
      --     },
      --   },
      --   telemetry = { enable = false },
      -- },
    },
    -- stylua = {},
    bashls                  = {},
    intelephense            = {

      stubs = {
        "bcmath",
        "bz2",
        "calendar",
        "Core",
        "curl",
        "zip",
        "zlib",
        "wordpress",
        "woocommerce",
        "acf-pro",
        "wordpress-globals",
        "wp-cli",
        "genesis",
        "polylang",
      },

      phpactor = {},
      phpstan = {},
      phpmd = {},
      phpcs = {},
      phpcbf = {},
      ["php-cs-fixer"] = {},
    },

    dockerls                = {},

    sqlls                   = {},
    -- marksman                = {
    --   filetypes = { "markdown", "markdown.mdx", "mdx" },
    -- },
    -- mdx_analyzer            = {
    --   filetypes = { "markdown", "markdown.mdx", "mdx" },
    -- },
    html                    = {},
    ansiblels               = {},
    yamlls                  = {}
  }

  local on_attach = function(_, bufnr)
    -- vim.lsp.inlay_hint.enable = true

    local map = vim.keymap.set

    local lsp_attach_buf_to_active_client = function()
      local clies = {}
      for i, v in ipairs(vim.lsp.get_clients()) do
        clies[i] = { v.id, v.name }
      end

      vim.ui.select(clies, {
        prompt = "Select a client to attach",
        format_item = function(item)
          return item[2]
        end,
      }, function(cli)
        if cli then
          vim.notify("Attaching to client: " .. cli[2])
          vim.lsp.buf_attach_client(0, cli[1])
        end
      end)
    end

    local opts = { buffer = bufnr }
    local withDesc = function(desc)
      local options = opts
      options["desc"] = desc
      return options
    end

    map("n", "<leader>lD", vim.lsp.buf.declaration, withDesc("vim.lsp.buf.declaration"))
    map("n", "<leader>dd", vim.lsp.buf.definition, withDesc("vim.lsp.buf.definition"))
    map("n", "<leader>ld", vim.lsp.buf.definition, withDesc("vim.lsp.buf.definition"))
    map("n", "<leader>li", vim.lsp.buf.implementation, withDesc("vim.lsp.buf.implementation"))
    map("n", "<leader>lk", vim.lsp.buf.type_definition, withDesc("vim.lsp.buf.type_definition"))
    map("n", "<leader>lr", vim.lsp.buf.references, withDesc("vim.lsp.buf.references"))

    map("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, withDesc("lsp_document_symbols,"))
    map(
      "n",
      "<leader>lws",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      withDesc("lsp_dynamic_workspace_symbols")
    )

    map("n", "<C-q>", vim.lsp.buf.signature_help, withDesc("vim.lsp.buf.signature_help"))
    map("i", "<C-q>", vim.lsp.buf.signature_help, opts)
    map("n", "K", vim.lsp.buf.hover, withDesc("vim.lsp.buf.hover"))

    map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, withDesc("vim.lsp.buf.add_workspace_folder"))
    map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, withDesc("vim.lsp.buf.remove_workspace_folder"))
    map("n", "<leader>lwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, withDesc("vim.lsp.buf.list_workspace_folders"))

    map("n", "<leader>ln", vim.lsp.buf.rename, withDesc("vim.lsp.buf.rename"))
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, withDesc("vim.lsp.buf.code_action"))

    -- map("n", "<leader>lf", function()
    --  vim.lsp.buf.format({ async = true })
    -- end, withDesc("vim.lsp.buf.format"))

    map("n", "]d", vim.diagnostic.goto_next, withDesc("vim.lsp.buf.references"))
    map("n", "[d", vim.diagnostic.goto_prev, withDesc("vim.lsp.buf.references"))

    -- map("n", "<leader>lC", "<cmd>TSContextToggle<cr>", withDesc("TSContextToggle"))
    -- map("n", "<leader>lt", "<cmd>TroubleToggle<cr>", { desc = "Trouble Toggle" })
    -- map("n", "<leader>lwd", function() require("trouble").toggle("workspace_diagnostics") end)
    -- map("n", "<leader>ldd", function() require("trouble").toggle("document_diagnostics") end)
    map("n", "<leader>la", "<cmd>AerialToggle<cr>", { desc = "Aerial Toggle" })

    map("n", "<F4>", lsp_attach_buf_to_active_client, { desc = "Select an active client to attach" })
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  require("mason").setup()
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  for key, value in pairs(servers) do
    vim.lsp.config(key, value)
    vim.lsp.enable(key)
  end

  vim.lsp.config('*', {
    capabilities = capabilities,
    on_attach = on_attach
  })


  vim.lsp.config('lua_ls', {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {}
    }
  })

  -- Turn on lsp status information
  require("fidget").setup({})

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh,bash,zsh",
    callback = function()
      vim.lsp.start({
        name = "bash-language-server",
        cmd = { "bash-language-server", "start" },
      })
    end,
  })
end

return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim",           tag = "v2.0.0" },
      -- { "williamboman/mason-lspconfig.nvim", tag = "v1.32.0" },
      { "williamboman/mason-lspconfig.nvim", tag = "v2.0.0" },

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim",                 event = "LspAttach" },
      -- Additional lua configuration, makes nvim stuff amazing
      -- "folke/neodev.nvim",
      {
        "folke/lsp-trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "LspAttach",
      },
      { "nvim-lua/plenary.nvim" },
    },
    config = configure,
  },
}
