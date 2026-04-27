" Compatibility
set nocompatible

" Plugin management
filetype off
filetype plugin indent on

" Leader key
let mapleader = ","

" Security
set modelines=0

" Line numbers
set number
set norelativenumber

" Status line
set ruler
set laststatus=2

" Display and rendering
set visualbell
set ttyfast
set showmode
set showcmd
set nowrap
set listchars=tab:▸\ ,eol:¬
map <leader>l :set list!<CR>

" 1term policy: no terminal mouse mode
set mouse=
set ttymouse=

" Colors
set t_Co=256
set background=dark
syntax on

" Encoding
set encoding=utf-8

" Whitespace and formatting
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set noautoindent
set nocindent

" Cursor movement
set scrolloff=3
set backspace=indent,eol,start

" Matching pairs
set matchpairs+=<:>
runtime! macros/matchit.vim

" Move by visual lines
nnoremap j gj
nnoremap k gk

" Buffer and window management
set hidden

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<CR>

" Remap help key
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Formatting
map <leader>q gqip
