execute pathogen#infect()

" auto enable
" neocomplete
let g:neocomplete#enable_at_startup = 1
" indent guides
let g:indent_guides_enable_on_vim_startup = 1


" Automatically cd into the directory that the file is in
set autochdir

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

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


set showcmd
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set hlsearch
set background=dark
set smartcase

" lets files determine the formatting. Keep disabled for security
"set modeline
"set modelines=5

syntax on

" options for vimdiff
set diffopt=filler
set diffopt+=iwhite

" options for nice folds
set foldmethod=marker

set wildmenu
set wildmode=list:longest,full

set tags=./tags;/


" Show invisible characters
"set invlist

" Folding Stuffs
set foldmethod=marker

" Ansible yaml indentation. Remove all indentation after blank lines
"let g:ansible_options = {'ignore_blank_lines': 0}
let g:ansible_unindent_after_newline = 1
let g:ansible_name_highlight = 'd'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_sh_shellcheck_args = '-x'

" airline
set laststatus=2
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" CtrlP

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" sets markdown files to github markdown
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" json formatting
augroup json_autocmd
  autocmd!
  au! BufRead,BufNewFile *.json set filetype=json
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

" base16 shell
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

"ack using ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"NERDTree shortcut
map <C-n> :NERDTreeToggle<CR>
