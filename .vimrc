filetype off
execute pathogen#infect()
syntax on

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

    " indentation per filetype
    autocmd FileType javascript setlocal shiftwidth=4 tabstop=4
    autocmd FileType sh setlocal shiftwidth=4 tabstop=4

  augroup END

  " nerdtree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " vim-pencil
  augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init()
    autocmd FileType text         call pencil#init()
  augroup END

endif " has("autocmd")

set history=1000    " keep 1000 lines of command line history

set shiftwidth=2
set tabstop=2
set relativenumber
set number
set shiftround
set expandtab
set cindent
set list
set showmatch
set cursorline
set undolevels=1000
set noerrorbells
set visualbell
set wrap
set scrolloff=5
set encoding=utf-8
set browsedir=buffer
set wildmode=longest,list,full
set ignorecase
set smartcase
set maxcombine=6
set shortmess+=A

" Don't use Ex mode, use Q for formatting
map Q gq

" General shortcuts
map <C-a> <Esc>ggVG<CR>
map <F3> <Esc>:noh<CR>
nnoremap <leader>s :update<CR>
nnoremap <silent> <tab><tab> mz:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>`z
vnoremap <silent> <tab><tab> :s/\s\+$//e<CR>

" nerdtree
let g:NERDTreeDirArrowExpandable = ">"
let g:NERDTreeDirArrowCollapsible = "@"
map <F5> :NERDTreeToggle<CR>

" rtl (hebrew)
let g:rtl_toggle_key="<F2>"
let g:rtl_keymap="hebrew_lyx"

" color settings
fu! InitColor()
  syntax enable
  set background=dark
  colorscheme pablo
  highlight LineNr cterm=NONE guibg=NONE guifg=#005500
  highlight CursorLineNr cterm=bold guibg=NONE guifg=#00ff00
  if has("gui_running")
    set go-=m
    set go-=T
    set go-=r
    set go-=L
    if has("win32")
      set guifont=Miriam_Fixed:h12:cHEBREW
      :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
      :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
      set linebreak
    else
      set guifont=Miriam\ Mono\ CLM\ 15
    endif
  endif
endfunction

:call InitColor()

" Goyo stuff
fu! Prose()
  Goyo 80x85%
  :call InitColor()
  set thesaurus=~\.vim\thesaurus\thesaurus-en.txt
  set isk+=32
  set spell
endfunction

fu! NoProse()
  Goyo!
  :call InitColor()
  set nolinebreak
  set thesaurus=
  set isk-=32
  set nospell
endfunction

map <F11> :call Prose()<CR>
map <F12> :call NoProse()<CR>
