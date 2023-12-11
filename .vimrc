set nocompatible
if has('vim_starting')
  set encoding=utf-8
endif

let mapleader = ' '
let maplocalleader = mapleader

silent! if plug#begin('~/.vim/bundle')
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'mhinz/vim-signify'
  let g:signify_vcs_list = ['git']

  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'mzh/vim-colors-solarized'
  call plug#end()
endif

runtime macros/matchit.vim

" Options
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

silent! colorscheme solarized

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
if exists('+breakindent')
  set breakindent
endif
set clipboard=unnamed,unnamedplus
if exists('+colorcolumn')
  set colorcolumn=80
endif
set complete-=i
set completeopt-=preview
if has('mac') && $VIM == '/usr/share/vim'
  set diffopt-=internal
elseif has('patch-8.1.0360')
  set diffopt+=algorithm:histogram,indent-heuristic
endif
set display=lastline
set expandtab
set foldmethod=marker
set formatoptions+=r
if has('patch-7.3.541')
  set formatoptions+=j
endif
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
if has('langmap') && exists('+langnoremap')
  set langnoremap
endif
set laststatus=2
set lazyredraw
set linebreak
set mouse=a
set nrformats-=octal
set number
if exists('+relativenumber')
  set relativenumber
endif
set ruler
set scrolloff=2
set sessionoptions-=options
set shiftround
set shiftwidth=4
if has('patch-8.1.1270')
  set shortmess-=S
endif
set showcmd
set showmode
set smartcase
set smarttab
set spelllang=en_us
set statusline=[%n]\ %<%f\ %h%m%r%=%{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %y\ %-14.(%l,%c%V%)\ %P
set tabstop=4
set ttimeout
set ttimeoutlen=10
set viewoptions-=options
set virtualedit=block
set wildignore+=*~,.*.sw?,tags
set wildmenu
set wildmode=full
set wrap

" Sundry files
set backupdir=/tmp//,.
set directory=/tmp//,.
if has('persistent_undo')
  set noundofile
  set undodir=/tmp//,.
endif
set viminfo+=!,/0,:0
set viminfofile=NONE

if has('path_extra')
  setglobal tags=./tags;
endif

" Line chars
set list
set listchars=tab:>\ ,trail:␣,extends:>,precedes:<,nbsp:+
set showbreak=↪\ 

" GUI options
if has('gui_running')
  set guicursor=a:block-Cursor,a:blinkon0
  set guioptions=c
endif

" Terminal options
set t_Co=16

" :grep
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
else
  set grepprg=grep\ -Hnr\ --exclude='*~'\ --exclude='.*.sw?'\ --exclude=tags\ $*
endif

" Mappings
nnoremap Q <Nop>
nnoremap Y y$

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

inoremap <CR> <C-G>u<CR>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

nnoremap <silent> <Leader>n :nohlsearch<CR>

command! DiffOrig vertical new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis

if has('autocmd')
  augroup filetypes
    autocmd!
    autocmd FileType c,cpp,java setlocal commentstring=//\ %s
    autocmd FileType *
        \   if exists('+omnifunc') && &omnifunc == ""
        \ |   setlocal omnifunc=syntaxcomplete#Complete
        \ | endif
    autocmd FileType gitcommit setlocal spell
  augroup END
endif
