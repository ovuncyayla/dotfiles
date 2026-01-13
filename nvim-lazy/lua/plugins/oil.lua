return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Space>b", "<cmd>Oil<CR>", desc = "Oil file browser" },
    -- { "<C-w>b", "<cmd>vert Oil<CR>", desc = "Oil file browser (vertical)" },
  },
  opts = {
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

        -- Open snacks picker files in current directory
        local function oil_files()
          local cur_dir = oil.get_current_dir()
          if cur_dir then
            Snacks.picker.files({ cwd = cur_dir })
          end
        end

        -- Open snacks picker grep in current directory
        local function oil_grep()
          local cur_dir = oil.get_current_dir()
          if cur_dir then
            Snacks.picker.grep({ cwd = cur_dir })
          end
        end

        -- Set buffer-local keymaps using <Space> explicitly
        vim.keymap.set("n", "<Space>y", oil_copy, { desc = "Oil copy path", buffer = ev.buf })
        vim.keymap.set("n", "f.", oil_files, { desc = "Oil files", buffer = ev.buf })
        vim.keymap.set("n", "g.", oil_grep, { desc = "Oil grep", buffer = ev.buf })

        -- Prevent shift+j/k from doing half-page scrolls in oil buffers
        vim.keymap.set("n", "<S-j>", "j", { desc = "Down one line", buffer = ev.buf })
        vim.keymap.set("n", "<S-k>", "k", { desc = "Up one line", buffer = ev.buf })
      end,
    })
  end,
}
