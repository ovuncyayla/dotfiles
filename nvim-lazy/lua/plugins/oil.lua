return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Space>b", "<cmd>Oil<CR>", desc = "Oil file browser" },
    -- { "<C-w>b", "<cmd>vert Oil<CR>", desc = "Oil file browser (vertical)" },
  },
  opts = {
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    view_options = {
      show_hidden = true,
    },
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = {
        "actions.select",
        opts = { vertical = true },
        desc = "Open the entry in a vertical split",
      },
      ["<C-x>"] = {
        "actions.select",
        opts = { horizontal = true },
        desc = "Open the entry in a horizontal split",
      },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["H"] = "actions.parent",
      ["L"] = "actions.select",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["gh"] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
  },
  init = function()
    -- Buffer-local keymaps for oil buffers (ftplugin equivalent)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function(ev)
        local oil = require("oil")

        -- Copy full path to clipboard
        local function oil_copy()
          local entry = oil.get_cursor_entry()
          local cur_dir = oil.get_current_dir()
          if entry and cur_dir then
            local entry_path = cur_dir .. entry.name
            vim.notify(entry_path)
            vim.fn.setreg("+", entry_path)
          end
        end

        -- Helper for snacks picker search in current directory
        local function oil_search(type, opts)
          local cur_dir = oil.get_current_dir()
          if cur_dir then
            opts = vim.tbl_extend("force", { cwd = cur_dir }, opts or {})
            if type == "files" then
              Snacks.picker.files(opts)
            elseif type == "grep" then
              Snacks.picker.grep(opts)
            end
          end
        end

        -- Set buffer-local keymaps using <Space> explicitly
        vim.keymap.set("n", "<Space>y", oil_copy, { desc = "Oil copy path", buffer = ev.buf })
        vim.keymap.set("n", "<Space>w", "<cmd>w<CR>", { desc = "Save", buffer = ev.buf })

        -- Robust Search mappings
        vim.keymap.set("n", "<Space>f", function()
          oil_search("files")
        end, { desc = "Search Files (Oil)", buffer = ev.buf })
        vim.keymap.set("n", "<Space>F", function()
          oil_search("files", { hidden = true, ignored = true })
        end, { desc = "Search Files (All, Oil)", buffer = ev.buf })
        vim.keymap.set("n", "<Space>g", function()
          oil_search("grep")
        end, { desc = "Grep (Oil)", buffer = ev.buf })
        vim.keymap.set("n", "<Space>G", function()
          oil_search("grep", { hidden = true, ignored = true })
        end, { desc = "Grep (All, Oil)", buffer = ev.buf })

        -- Prevent shift+j/k from doing half-page scrolls in oil buffers
        vim.keymap.set("n", "<S-j>", "j", { desc = "Down one line", buffer = ev.buf })
        vim.keymap.set("n", "<S-k>", "k", { desc = "Up one line", buffer = ev.buf })
      end,
    })
  end,
}
