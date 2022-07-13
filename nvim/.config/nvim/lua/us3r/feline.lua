local status_ok, feline = pcall(require, "feline")
if status_ok then
  feline.setup({
      components = require('catppuccin.core.integrations.feline'),
    })
else
  vim.notify("Feline not found!")
end
