-- Set options
vim.opt.backspace="indent,eol,nostop" -- Don't stop backspace at i
vim.opt.clipboard="unnamedplus" -- Connection to the system clipboard
vim.opt.completeopt="menuone,noselect" -- Options for insert mode comple
vim.opt.copyindent=true -- Copy the previous indentation on autoindenting
vim.opt.cursorline=true -- Highlight the text line of the cursor
vim.opt.expandtab=true -- Enable the use of space in tab
--vim.opt.fileencoding="utf-8" -- File content encoding for the buffer
--vim.opt.fillchars+="eob:' '" -- Disable `~` on nonexistent lines
vim.opt.history=100 -- Number of commands to remember in a history table
vim.opt.ignorecase=true -- Case insensitive searching
vim.opt.laststatus=3 -- globalstatus
vim.opt.lazyredraw=true -- lazily redraw screen
vim.opt.mouse="a" -- Enable mouse support
vim.opt.number=true -- Show numberline
vim.opt.preserveindent=true -- Preserve indent structure as much as possible
vim.opt.pumheight=10 -- Height of the pop up menu
vim.opt.relativenumber=true -- Show relative numberline
vim.opt.scrolloff=8 -- Number of lines to keep above and below the cursor
vim.opt.shiftwidth=2 -- Number of space inserted for indentation
vim.opt.showmode=false -- Disable showing modes in command line
vim.opt.sidescrolloff=8 -- Number of columns to keep at the sides of the cursor
vim.opt.signcolumn="yes" -- Always show the sign column
vim.opt.smartcase=true -- Case sensitivie searching
vim.opt.splitbelow=true -- Splitting a new window below the current one
vim.opt.splitright=true -- Splitting a new window at the right of the current o
vim.opt.swapfile=false -- Disable use of swapfile for the buffer
vim.opt.tabstop=2 -- Number of space in a tab
vim.opt.termguicolors=true -- Enable 24-bit RGB color in the TUI
vim.opt.timeoutlen=300 -- Length of time to wait for a mapped sequence
vim.opt.undofile=true -- Enable persistent undo
vim.opt.updatetime=300 -- Length of time to wait before triggering the plugin
vim.opt.wrap=false -- Disable wrapping of lines longer than the width of window
vim.opt.writebackup=false -- Disable making a backup before overwriting a file
vim.opt.list=true

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.cmd [[colorscheme rose-pine]]
vim.o.termguicolors = true
vim.g.transparent_background = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- vim.cmd [[highlight Normal ctermbg=none guibg=none]]
-- vim.cmd [[highlight NonText ctermbg=none guibg=none]]
