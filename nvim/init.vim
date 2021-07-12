" Plugins {{{
call plug#begin(stdpath("config") . '/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'puremourning/vimspector'
call plug#end()
" }}}

"Theme
autocmd vimenter * ++nested colorscheme gruvbox

" Common
set relativenumber
set clipboard+=unnamedplus
set incsearch
setlocal foldmethod=marker
setlocal foldlevelstart=0
set grepprg=rg
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set hidden

let mapleader = " "
let maplocalleader = "\\"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>pf <cmd>Telescope git_files<cr>

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

augroup filetype_vim
    " autocmd!
    autocmd Filetype vim nnoremap <buffer> <leader>ss :source "%:p"<cr>
augroup END


let g:vimspector_install_gadgets = [ 'debugpy', 'CodeLLDB' ]
let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )

let g:vimspector_enable_mappings = 'HUMAN'
