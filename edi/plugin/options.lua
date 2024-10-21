vim.o.clipboard = "unnamedplus"      -- Connection to the system clipboard
vim.o.cursorline = true              -- Highlight the text line of the cursor
vim.o.expandtab = true               -- Enable the use of space in tab
vim.o.smartcase = true
vim.o.ignorecase = true -- Case insensitive searching
vim.o.number = true -- Show numberline
vim.o.relativenumber = true -- Show relative numberline
vim.o.scrolloff = 8 -- Number of lines to keep above and below the cursor
vim.o.shiftwidth = 2 -- Number of space inserted for indentation
vim.o.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
vim.o.signcolumn = "yes" -- Always show the sign column
vim.o.splitbelow = true -- Splitting a new window below the current one
vim.o.splitright = true -- Splitting a new window at the right of the current o
vim.o.swapfile = false -- Disable use of swapfile for the buffer
vim.o.tabstop = 2 -- Number of space in a tab
vim.o.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.o.timeoutlen = 300 -- Length of time to wait for a mapped sequence
vim.o.updatetime = 300 -- Length of time to wait before triggering the plugin
vim.o.wrap = false -- Disable wrapping of lines longer than the width of window
vim.o.writebackup = false -- Disable making a backup before overwriting a file
vim.o.list = true
vim.o.listchars = "tab:∘ ,trail:∘" --,nbsp:󰯉,eol:󰯉"
vim.o.laststatus = 2
vim.o.showtabline = 0
vim.o.hlsearch = false
vim.o.undofile = true
vim.o.showmode = false
-- vim.o.completeopt = 'menuone,noselect'
vim.g.netrw_banner = 0

-- vim.cmd([[ colorscheme sorbet ]])
vim.cmd("hi! Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi! NonText guibg=NONE ctermbg=NONE")
