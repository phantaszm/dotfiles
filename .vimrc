" Remove any trailing whitespace that is in the file
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Load indentation rules and plugins according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" disable auto commenting
" Long version of below: autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType * setlocal fo-=cro


"-- ui options
set background=dark
set showcmd
set colorcolumn=80
"set wrap
set termguicolors
set scrolloff=9
syntax on
" Show invisible characters
"set invlist

"-- spaces for tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

" -- search
set ignorecase
set smartcase
set incsearch
"set hlsearch

"-- options for vimdiff
set diffopt=filler
set diffopt+=iwhite

"-- nice folds
set foldmethod=marker

"-- nav options
set autochdir

"-- misc
set wildmenu
set wildmode=list:longest,full
set tags=./tags;/

