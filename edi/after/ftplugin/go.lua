vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	group = vim.api.nvim_create_augroup("GoEnter", { clear = true }),
  pattern = { "*.go", "go.mod", "go.sum", "go.work", "go.work.sum" },
	callback = function()
    vim.o.listchars = "tab:  ,trail:∘" --,nbsp:󰯉,eol:󰯉"
    vim.fn.execute('retab')
	end,
})
vim.api.nvim_create_autocmd("BufLeave", {
	group = vim.api.nvim_create_augroup("GoLeave", { clear = true }),
  pattern = { "*.go", "go.mod", "go.sum", "go.work", "go.work.sum" },
	callback = function()
    vim.o.listchars = "tab:∘ ,trail:∘" --,nbsp:󰯉,eol:󰯉"
    vim.fn.execute('retab')
	end,
})
