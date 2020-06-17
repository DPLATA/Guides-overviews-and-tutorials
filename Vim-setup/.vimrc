" enable syntax highlighting 
syntax on

" no sound FX
set noerrorbells

" indentation settings
" setting visual spaces per TAB and number of spaces in tab when editing
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" set line numbers to relative
set rnu

" backup settings
set nobackup
set undodir=~/.vim/undodir
set undofile

" search for characters as they are being typed ie. /search
set incsearch

set nowrap
set smartcase
set noswapfile

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


" plugins installation
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'git@github.com:ycm-core/YouCompleteMe.git'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'preservim/nerdtree'
call plug#end()


" setting gruvbox to default colorscheme and background dark
colorscheme gruvbox
set background=dark

let mapleader = ','

nnoremap <leader>t :NERDTree<CR>
map  <leader>l :wincmd w<CR> 
