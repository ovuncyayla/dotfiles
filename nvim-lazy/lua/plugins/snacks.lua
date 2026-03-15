return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>fz", function() Snacks.picker.zoxide() end, desc = "Zoxide" },
    {
      "<leader>e",
      function()
        local items = {}
        -- 1. Favorites
        local favs = {
          { "🏠 Home", vim.env.HOME },
          { "📂 Documents", vim.env.HOME .. "/Documents" },
          { "📥 Downloads", vim.env.HOME .. "/Downloads" },
          { "💻 Projects", vim.env.HOME .. "/Projects" },
          { "⚙️ Dotfiles", vim.env.HOME .. "/dotfiles" },
          { "🖼️ Pictures", vim.env.HOME .. "/Pictures" },
          { "🎥 Videos", vim.env.HOME .. "/Videos" },
        }
        for _, fav in ipairs(favs) do
          if vim.fn.isdirectory(fav[2]) == 1 then
            table.insert(items, { text = fav[1], file = fav[2], label = fav[1] })
          end
        end

        -- 2. Zoxide frequent dirs (top 15)
        local z_paths = vim.fn.systemlist("zoxide query -l | head -n 15")
        for _, path in ipairs(z_paths) do
          table.insert(items, { text = "⚡ " .. path, file = path, label = "Zoxide" })
        end

        -- 3. Bookmarks and Mounts (matching your script's find logic)
        local extra_roots = {
          { path = vim.env.HOME .. "/bookmarks", icon = "🔖 ", label = "Bookmark" },
          { path = "/mnt", icon = "💾 ", label = "Mount" },
        }

        for _, root in ipairs(extra_roots) do
          if vim.fn.isdirectory(root.path) == 1 then
            local cmd = string.format("find -L %s -mindepth 1 -maxdepth 4 -not -path '*/.*' -type d 2>/dev/null", root.path)
            local found = vim.fn.systemlist(cmd)
            for _, path in ipairs(found) do
              table.insert(items, { text = root.icon .. path, file = path, label = root.label })
            end
          end
        end

        Snacks.picker({
          prompt = "Jump Anywhere ",
          items = items,
          layout = { preset = "vscode" }, -- Clean layout
          confirm = function(picker, item)
            picker:close()
            if item then
              require("oil").open(item.file)
            end
          end,
        })
      end,
      desc = "Jump Anywhere (Mirror Rofi-Thunar)",
    },
  },
  opts = {
    picker = {
      sources = {
        explorer = {
          layout = {
            auto_hide = false, -- { "input" }, -- Change this to false to keep the search box visible
          },
        },
      },
    },
  },
}
