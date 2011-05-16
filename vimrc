" This must be first, becuase it changes other options as side effect
set nocompatible

let mapleader = ","

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set t_Co=256

" solarized options
" set background=light
" let g:solarized_termcolors=256
" colorscheme solarized

let coffee_compile_on_save = 0

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &t_Co >= 256 || has("gui_running")
  colorscheme clarity
  if has("gui_gtk2")
    set guifont=Menlo\ 11
  endif
endif

set backspace=indent,eol,start
set copyindent      " copy the previous indentation on autoindenting
set expandtab
set formatprg=par
set guioptions-=T   " remove toolbar
"set guioptions-=m   " remove menu bar
" set guioptions-=r   " remove right-hand scroll bar
" set hidden          " hides buffers instead of closing them
set history=1000
set ignorecase      " ignore case when searching
set incsearch       " interactive search
set linebreak
set list
set listchars=tab:>-,trail:·,extends:…,nbsp:·
set nobackup
set noswapfile
set nowrap
set number          " always show line numbers
set pastetoggle=<F2>
set ruler           " always display the current cursor position
set shiftwidth=2
set showcmd         " displays incomplete command
set showmatch       " show matching parenthesis
set smartcase       " ignore case when pattern is all lowercase
set smartindent
set smarttab        " insert tabs on the start of a line according to shiftwidth
set spelllang=es
set tabstop=2
set title
set undolevels=1000
set noerrorbells
" set visualbell
set wildignore=*.swp,*.bak,*.pyc,*.class

nmap <F12> :set guifont=Menlo\ 20<CR>
nmap <F11> :set guifont=Menlo\ 11<CR>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap ; :
cmap w!! w !sudo tee % > /dev/null
nmap <silent> <leader>tw :ToggleWord<CR>
nmap <silent> <leader>ev :tabedit $MYVIMRC<CR>
nmap <silent> ,/ :nohlsearch<CR>

if has('mouse')
  set mouse=a
endif

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
  autocmd FileType python set expandtab
  autocmd FileType html,xml set listchars-=tab:>.

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

  augroup END
else
  set autoindent  " always set autoindenting on
endif " has("autocmd")

" if has("autocmd")
"   autocmd bufwritepost .vimrc source $MYVIMRC
" endif

" zen coding options
let g:user_zen_settings = {
\  'indentation': '  ',
\  'perl': {
\    'aliases': {
\      'req': 'require'
\    },
\    'snippets': {
\      'use': "use strict\nuse warnings\n\n",
\      'warn': "warn \"|\";",
\    }
\  }
\}

let g:user_zen_expandabbr_key='<C-o>'
let g:use_zen_complete_tag=1

" RSpec function hilight
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject
highlight def link rubyRspec Function
