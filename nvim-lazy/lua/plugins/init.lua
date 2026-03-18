-- this ensures LazyVim is setup properly
require("lazy.core.handler").setup()

-- You can add your plugins here
return {
  { import = "plugins.configs" },
  { import = "plugins.community" },
  -- import/override with your plugins
  { import = "plugins.user" },
}

