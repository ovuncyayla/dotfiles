vim.keymap.set("n", "<C-n>", require("kulala").jump_next, { desc = "Jump to next request", buffer = true })
vim.keymap.set("n", "<C-p>", require("kulala").jump_prev, { desc = "Jump to previous request", buffer = true })
vim.keymap.set("n", "<CR>", require("kulala").run, { desc = "Run request", buffer = true })
vim.keymap.set("n", "<Space><CR>", require("kulala").run_all, { desc = "Run all requests", buffer = true })
