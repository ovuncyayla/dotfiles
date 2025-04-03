vim.filetype.add({
  filename = {
    ["go.mod"] = "go",
    ["go.sum"] = "go",
    ["go.work"] = "go",
    ["go.work.sum"] = "go",
  },
	extension = {
		JSON = "json",
    postcss = "postcss",
    htmx = "html",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("SyntaxFold", { clear = true }),
	pattern = "gitcommit,git",
	callback = function()
		vim.wo.foldmethod = "syntax"
		vim.keymap.set("n", "<Tab>", "za", { desc = "Toggle fold under cursor", buffer = true })
		vim.keymap.set("n", "=", "za", { desc = "Toggle fold under cursor", buffer = true })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})
