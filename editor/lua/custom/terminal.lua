-- map("n", "<C-\\><C-\\>", "<cmd>ToggleTerm direction=tab<cr>", { desc = "ToggleTerm Tab" })
-- map("n", "<C-\\><C-\\>", "<cmd>ToggleTerm direction=vertical size=<cr>", { desc = "ToggleTerm Vertical" })
-- map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "ToggleTerm Win Left" })
-- map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "ToggleTerm Win Up" })
-- map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "ToggleTerm Win Down" })
-- map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "ToggleTerm Right" })
-- map('t', '<C-w>', [[<C-\><C-n><C-w>]], { desc = "ToggleTerm Wincmd" })
--

local map = vim.keymap.set

map('t', '<esc>', [[<C-\><C-n>]], { desc = "ToggleTerm Normal Mode" })
map('t', 'jk', [[<C-\><C-n>]], { desc = "ToggleTerm Normal Mode" })

require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
  end,
  open_mapping = [[<c-\>]],
  direction = "tab"
}
