vim.keymap.set("n", "<leader>m", ":%!jq --indent 0 <CR>", { desc = "Minify json", buffer = true })
vim.keymap.set("n", "<leader>b", ":%!jq<CR>", { desc = "Beautify json", buffer = true })
