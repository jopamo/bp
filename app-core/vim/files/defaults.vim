" Compatibility
set nocompatible " Don't try to be vi compatible

" Plugin Management
filetype off " Helps force plugins to load correctly
" TODO: Load plugins here (pathogen or vundle)
filetype plugin indent on " For plugins to load correctly

" Leader Key
" let mapleader = "," " TODO: Pick a leader key

" Security
set modelines=0 " Security settings

" Line Numbers
set number " Show line numbers
set norelativenumber " Disable relative line numbers

" Status Line
set ruler " Show file stats
set laststatus=2 " Always show status bar

" Display and Rendering
set visualbell " Blink cursor on error instead of beeping
set ttyfast " Faster rendering
set showmode " Show current mode
set showcmd " Show command in last line
set listchars=tab:▸\ ,eol:¬ " Visualize tabs and newlines
" Toggle tabs and EOL
map <leader>l :set list!<CR>

" Encoding
set encoding=utf-8 " Set encoding to UTF-8

" Whitespace and Formatting
set wrap " Wrap text
set textwidth=79 " Set text width
set formatoptions=tcqrn1 " Formatting options
set tabstop=2 " Number of spaces per tab
set shiftwidth=2 " Number of spaces for indenting
set softtabstop=2 " Number of spaces per tab when editing
set expandtab " Use spaces instead of tabs
set noshiftround " Disable rounding when shifting
set noautoindent " Disable automatic indentation
set nocindent " Disable C-style indentation
set nowrap " Disable line wrapping

" Cursor Movement
set scrolloff=3 " Number of lines to keep above/below cursor
set backspace=indent,eol,start " Configure backspace behavior

" Matching Pairs
set matchpairs+=<:> " Use % to jump between pairs
runtime! macros/matchit.vim

" Move Up/Down Editor Lines
nnoremap j gj
nnoremap k gk

" Buffer and Window Management
set hidden " Allow hidden buffers

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch " Highlight search results
set incsearch " Show search matches as you type
set ignorecase " Ignore case in searches
set smartcase " Override ignorecase if search contains uppercase
set showmatch " Show matching parentheses
map <leader><space> :let @/=''<cr> " Clear search highlight

" Remap Help Key
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate Holdouts
" Formatting
map <leader>q gqip " Format paragraph
