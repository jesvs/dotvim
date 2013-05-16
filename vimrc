" This must be first, becuase it changes other options as side effect
set nocompatible
set laststatus=2
set encoding=utf-8
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'Align'
Bundle 'Lokaltog/vim-powerline'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'godlygeek/tabular'
Bundle 'toggle_words.vim'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'pangloss/vim-javascript'
Bundle 'digitaltoad/vim-jade'
Bundle 'groenewege/vim-less'
Bundle 'kien/ctrlp.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'UltiSnips'
Bundle 'goldfeld/vim-seek'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
Bundle 'slim-template/vim-slim'

let g:Powerline_symbols='fancy'

let mapleader = ","

filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

set t_Co=256

" solarized options
" set background=light
" let g:solarized_termcolors=256
" colorscheme solarized

let coffee_compile_on_save = 0

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  colorscheme molokai-moi
endif

set backspace=indent,eol,start
set copyindent      " copy the previous indentation on autoindenting
set noexpandtab
set formatprg=par
"set hidden          " hides buffers instead of closing them
set history=1000
set ignorecase      " ignore case when searching
set incsearch       " interactive search
set linebreak
set nolist
"set listchars=tab:››,trail:·,extends:…,nbsp:·
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
set wildignore=*.swp,*.bak,*.pyc,*.class,*.db

nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k

nmap <CR> :write<CR>

nnoremap ; :
cmap w!! w !sudo tee % > /dev/null<CR>
cmap wc w !haml % ${'%'/haml/html}<CR>
nmap <silent> <leader>tw :ToggleWord<CR>
nmap <silent> <leader>ev :tabedit $MYVIMRC<CR>
nmap <silent> ,/ :nohlsearch<CR>
nmap <silent> <leader>== :Tabularize/=/

function! HamlCompile()
  let cmdtype = getcmdtype()
  if cmdtype == ':'
    " compile haml and save it as html
    w
    !haml % test.html
  endif
endfunction

if has('mouse')
  set mouse=a
endif
"if has("gui_running")
"	set mouse=a
"else
"	set mouse-=a
"endif

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
  "autocmd FileType python set expandtab
  "autocmd FileType html,xml set listchars-=tab:››
  autocmd FileType haml,scss,sass setlocal noexpandtab "list
  "autocmd FileType fstab setlocal noexpandtab list listchars=tab:››
  autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject
  autocmd BufReadPost Gemfile,.autotest,config.ru setlocal syntax=ruby
	"autocmd BufReadPost .autotest setlocal syntax=ruby
  highlight def link rubyRspec Function
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

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

au BufWritePost *.haml call HamlMake()
" Inspired by Mark Hansen's python dependent function
" http://markhansen.co.nz/autocompiling-haml/
" Create an empty .autohaml to auto compile your haml files on save
function! HamlMake()
	if filereadable(expand('%:p:h')."/.autohaml")
		let hamlinput = expand('%:p')
		let htmloutput = substitute(hamlinput, ".haml", ".html", "")
		execute 'silent !haml % '.htmloutput
	endif
endfunction

au BufWritePost *.scss call ScssMake()
function! ScssMake()
	if filereadable(expand('%:p:h')."/.autoscss")
		let scssinput = expand('%:p')
		let cssoutput = substitute(scssinput, ".scss", ".css", "")
		execute 'silent !scss % '.cssoutput
	endif
endfunction
