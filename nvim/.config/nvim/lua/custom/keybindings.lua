local map = vim.keymap.set

map("n", "<leader>.", "<cmd>cd %:p:h<cr>", { desc = "Set CWD" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader><leader>s", "<cmd>source %<cr>", { desc = "Source Current File" })

-- Bufdelete
map("n", "<leader>q", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
-- map("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })


map("n", "<leader>sb", function() require("telescope").extensions.file_browser.file_browser() end, { desc = "[S]earch Files [B]rowser" })

