-- this ensures LazyVim is setup properly
require("lazy.core.handler").setup()

-- transparent background
vim.o.termguicolors = true
vim.cmd("highlight Normal guibg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE")

-- You can add your plugins here
return {
  { import = "plugins.configs" },
  { import = "plugins.community" },
  -- import/override with your plugins
  { import = "plugins.user" },
}
