" Plugins {{{
call plug#begin($HOME . '/.vim/plugged')

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

Plug 'simrat39/rust-tools.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'vimwiki/vimwiki'
Plug 'mustache/vim-mustache-handlebars'
call plug#end()
" }}}

lua require("confs")

"Theme
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox

let mapleader = " "
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>u :UndotreeShow<CR>

inoremap lkj <esc>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
