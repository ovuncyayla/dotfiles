local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Error while loading lspconfig")
  return
end

require "us3r.lsp.configs"
require "us3r.lsp.handlers"
require "us3r.lsp.null-ls"
