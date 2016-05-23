set nocompatible
if has('vim_starting')
  set encoding=utf-8
endif

let mapleader      = ' '
let maplocalleader = mapleader

" Plugins {{{
silent! if plug#begin('~/.vim/bundle')
  Plug 'osyo-manga/vim-anzu'
  let g:anzu_status_format = '%p (%i/%l)'

  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)

  Plug 'tpope/vim-characterize'
  Plug 'tpope/vim-commentary'
  Plug 'chrisbra/vim-diff-enhanced'
  set diffexpr=EnhancedDiff#Diff('git\ diff')

  Plug 'justinmk/vim-dirvish'
  nnoremap <Leader>e :Dirvish %:p:h<CR>

  Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)', 'EasyAlign']}
  nmap gl <Plug>(EasyAlign)
  xmap gl <Plug>(EasyAlign)

  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
  Plug 'junegunn/fzf.vim'
  nnoremap <Leader>f :Files<CR>

  Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
  nnoremap <Leader>g :Goyo<CR>

  Plug 'tpope/vim-repeat'
  Plug 'airblade/vim-rooter'
  let g:rooter_disable_map  = 1
  let g:rooter_silent_chdir = 1

  Plug 'mhinz/vim-signify'
  let g:signify_vcs_list = ['git']

  Plug 'tpope/vim-sleuth'
  Plug 'AndrewRadev/splitjoin.vim'
  let g:splitjoin_join_mapping  = ''
  let g:splitjoin_split_mapping = ''

  nnoremap gsj :SplitjoinJoin<CR>
  nnoremap gss :SplitjoinSplit<CR>

  Plug 'tpope/vim-surround'
  Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
  let g:undotree_DiffCommand     = 'git diff --no-index --no-color --no-ext-diff'
  let g:undotree_DiffpanelHeight = 15
  let g:undotree_WindowLayout    = 2

  nnoremap <Leader>u :UndotreeToggle<CR>

  Plug 'tpope/vim-unimpaired'
  Plug 'thinca/vim-visualstar'

  " Snippets
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsListSnippets = '<S-Tab>'

  Plug 'honza/vim-snippets'

  " Language-specific
  Plug 'lervag/vimtex'
  Plug 'vim-ruby/vim-ruby'

  " Linting
  if has('nvim')
    Plug 'benekastah/neomake'
    let g:neomake_open_list    = 1
    let g:neomake_error_sign   = {'text': '>>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': '>>', 'texthl': 'Warning'}
    let g:neomake_verbose      = 0
  else
    Plug 'scrooloose/syntastic'
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list            = 1
  endif

  " Color scheme
  Plug 'mzh/vim-colors-solarized'
  call plug#end()
endif

runtime macros/matchit.vim

" }}}
" Options {{{
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
set shiftround
set shiftwidth=4
set shortmess+=a
set showcmd
set showmode
set smartcase
set smarttab
set spelllang=en_us
set statusline=[%n]\ %<%f\ %h%m%r%=%{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %y\ %-14.(%l,%c%V%)\ %P
set tabstop=4
set ttimeout
set ttimeoutlen=10
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

if has('path_extra')
  setglobal tags=./tags;
endif

" Displayed characters
set list
set listchars=tab:>\ ,trail:␣,extends:>,precedes:<,nbsp:+
set showbreak=↪\ 

" GUI options
if has('gui_running')
  set guicursor=a:block-Cursor,a:blinkon0
  if has('gui_gtk2')
    set guifont=Monospace\ 10
  endif
  set guioptions=c
endif

" Terminal options
set t_Co=16

" :grep
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat^=%f:%l:%c:%m
else
  set grepprg=grep\ -Hnr\ --exclude='*~'\ --exclude='.*.sw?'\ --exclude=tags\ $*
endif

" }}}
" Mappings {{{
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

" }}}
" Commands {{{
command! DiffOrig vertical new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Autocommands
if has('autocmd')
  if exists('g:plugs')
    " dirvish.vim
    augroup dirvish
      autocmd!
      autocmd FileType dirvish call fugitive#detect(@%)
      autocmd FileType dirvish nnoremap <buffer> gh :keeppatterns g@\v/\.[^\/]+/?$@d<CR>
    augroup END

    " goyo.vim
    autocmd! User GoyoEnter nested call <SID>GoyoEnter()
    autocmd! User GoyoLeave nested call <SID>GoyoLeave()

    function! s:GoyoEnter()
      if exists('+breakindent')
        set nobreakindent
      endif
      set scrolloff=999
      set showbreak=""
      set noshowcmd
      set noshowmode
    endfunction

    function! s:GoyoLeave()
      if exists('+breakindent')
        set breakindent
      endif
      set scrolloff=2
      set showbreak=↪\ 
      set showcmd
      set showmode
    endfunction

    " neomake
    if has('nvim')
      autocmd! BufWritePost * Neomake
    endif
  endif

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

" }}}
