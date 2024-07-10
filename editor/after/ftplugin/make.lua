vim.notify("After Makefile")

vim.bo.tabstop = 4
vim.keymap.set('n', '<Tab>', ':%retab!<cr>', { desc = "Retab whole file", buffer = true })
vim.bo.expandtab = false
-- vim.fn.execute('set noexpandtab')

vim.api.nvim_create_autocmd("BufWrite", {
  group = vim.api.nvim_create_augroup("Makey", { clear = true }),
  pattern = "Makefile",
  callback = function(ev)
    vim.fn.execute('%retab!')
  end
})
