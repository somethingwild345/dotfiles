" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(stdpath('data') . '/plugged')

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'

" FZF
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'coreyja/fzf.devicon.vim'

" Language servers and intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'fatih/vim-go' 
Plug 'mattn/emmet-vim'
Plug 'honza/vim-snippets'
Plug 'plasticboy/vim-markdown'
Plug 'editorconfig/editorconfig-vim'
Plug 'pantharshit00/vim-prisma'         " Prisma syntax highlighting

Plug 'jiangmiao/auto-pairs'             " Insert or delete brackets, parens, quotes in pair
Plug 'tpope/vim-surround'               " Quoting/parenthesizing made simple
Plug 'tpope/vim-commentary'             " Comment stuff out
Plug 'tpope/vim-repeat'                 " Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-unimpaired'             " Pairs of handy bracket mappings
Plug 'skywind3000/asyncrun.vim'		      " Run Async Shell Commands
Plug 'easymotion/vim-easymotion'        " Vim motions on speed
Plug 'psliwka/vim-smoothie'             " Smooth scrolling for vim
Plug 'airblade/vim-rooter'              " Changes Vim working directory to project root
Plug 'ludovicchabant/vim-gutentags'     " Manages your tag files automatically

Plug 'voldikss/vim-floaterm'            " Terminal manager for (neo)vim
Plug 'mcchrish/nnn.vim'		        	" Integration of nnn with vim
Plug 'AndrewRadev/splitjoin.vim'	    " Switch between single-line and multiline forms

Plug 'folke/tokyonight.nvim'
Plug 'itchyny/lightline.vim'            " A light and configurable statusline
Plug 'sheerun/vim-polyglot'             " Syntax Highlighting And Indentation
Plug 'Yggdroot/indentLine'              " Display the indention levels
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'wakatime/vim-wakatime'
Plug 'ryanoasis/vim-devicons'           " Adds file type icons

call plug#end()