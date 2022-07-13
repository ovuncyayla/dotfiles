local status_ok, luasnip = pcall(require, 'luasnip')

if status_ok then
  require("luasnip.loaders.from_vscode").lazy_load()
else
  vim.notify("Unable to load LuaSnip!")
end
