" Plugins {{{
call plug#begin(stdpath("config") . '/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'

Plug 'ambv/black'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

Plug 'rust-lang/rust.vim'
Plug 'darrikonn/vim-gofmt'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'sbdchd/neoformat'

call plug#end()
" }}}

"Theme
autocmd vimenter * ++nested colorscheme gruvbox

let mapleader = " "
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>pf <cmd>Telescope git_files<cr>
nnoremap <leader>fd <cmd>Telescope project<cr>

nnoremap <leader>u :UndotreeToggle<CR>

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

augroup filetype_vim
    " autocmd!
    autocmd Filetype vim nnoremap <buffer> <leader>ss :source "%:p"<cr>
augroup END

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

let g:vimspector_install_gadgets = [ 'debugpy', 'CodeLLDB' ]
let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )

let g:vimspector_enable_mappings = 'HUMAN'
