vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("FE", { clear = true }),
  pattern = "*.postcss",
  callback = function()
    vim.bo.filetype = "postcss"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("SyntaxFold", { clear = true }),
  pattern = "gitcommit,git",
  callback = function()
    vim.wo.foldmethod = 'syntax'
    vim.keymap.set('n', '<Tab>', 'za', { desc = "Toggle fold under cursor", buffer = true })
    vim.keymap.set('n', '=', 'za', { desc = "Toggle fold under cursor", buffer = true })
  end
})

