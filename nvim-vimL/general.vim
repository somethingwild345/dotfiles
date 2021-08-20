set termguicolors               " Fix True colors
filetype plugin indent on       " Automatically detect file types.
syntax on                       " Enable Syntax highlighting
set encoding=UTF-8

set clipboard+=unnamedplus      " Share clipboard with system
set virtualedit=onemore         " Allow for cursor beyond last character
set history=1000                " Increase history limit
set hidden                      " Hide buffers instead of closing

set noshowmode                  " Hide current mode, like: -- INSERT --
set cursorline                  " Highlight current line
set tabpagemax=20               " Max number of tabs
set showcmd                     " Show commands in status line

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on

set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase                  " Ignore case when search
set smartcase                   " Switch to case sensitive when upper case exist

set wildmenu                    " Show list instead of just completing
set wildignore+=**/node_modules/**,**/dist/**,**/vendor/**
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set wrap                        " Enable line wrapping
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set autoindent                  " Inherit the indentation of previous lines
set expandtab                   " Tabs are spaces
set shiftwidth=4                " Use indents of 4 spaces
set tabstop=4                   " Indent using four spaces
set softtabstop=4               " Let backspace delete indent
set smarttab                    " Use smart tab

set splitright                  " Open vsplit to the right
set splitbelow                  " Open split to the bottom

set updatetime=300              " Reduce time to 300 ms
set shortmess+=c		" Don't pass messages to |ins-completion-menu|.

" Always show the signcolumn
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set nobackup                    " Turn backup off
set noswapfile
set nowritebackup

set lazyredraw                  " Don't redraw while executing macros
set complete-=i                 " Limit the files searched for auto-completes
set ruler                       " Always show current position
set cmdheight=1                 " Height of the command bar

set textwidth=80                " Set max line width to 80
set formatoptions+=t
set colorcolumn=+1

set magic                       " For regular expressions
set foldcolumn=1                " Add extra margin to the left
set autoread                    " Detect if a file have been changed outside of Vim
set nrformats-=octal            " Interpret octal as decimal
set shortmess+=c                " Don't pass messages to |ins-completion-menu|

:set number relativenumber      " Toggle Hybrid Numbers in insert and normal mode

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Disable python2 provider
let g:loaded_python_provider=0
let g:loaded_ruby_provider=0
let g:loaded_node_provider=0
let g:loaded_perl_provider=0