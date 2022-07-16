local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if status_ok then
  lsp_installer.setup({
    ui = {
      icons = {
        server_installed = "✓",
        server_uninstalled = "✗",
        server_pending = "⟳",
      },
    },
  })
else
  vim.notify("unable to load nvim-lsp-installer")
end
