local ok, lsp_signature = pcall(require, 'lsp_signature')
if not ok then
  vim.notify('Unable to configure lsp_signature')
  return
end

lsp_signature.setup()
