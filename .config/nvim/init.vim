call plug#begin('~/.vim/plugged')

" --- File Handling ---
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" --- Languages ---
Plug 'cespare/vim-toml'         " TOML Support
Plug 'plasticboy/vim-markdown'  " Markdown Support
Plug 'vim-latex/vim-latex'      " Better Latex Support
Plug 'WolfgangMehner/c-support' " C / C++ Language Support
Plug 'rust-lang/rust.vim'       " Rust Langauge
Plug 'fatih/vim-go'             " Golang
Plug 'python-mode/python-mode'  " Better support for Python
Plug 'pangloss/vim-javascript'  " Better support for Javascript

" --- Utilities ---
Plug 'godlygeek/tabular'  " Text Alignment
Plug 'tpope/vim-fugitive' " Git Integration
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --- Themes ---
Plug 'dracula/vim'
Plug 'larsbs/vimterial'
Plug 'jdkanani/vim-material-theme'

call plug#end()

syntax on
filetype plugin on
filetype indent on

" color dracula
" color vimterial
color material-theme

set background=dark
set tabstop=4
set number

let g:airline_theme='distinguished'
let g:airline#extensions#tabline#show_tabs = 1
