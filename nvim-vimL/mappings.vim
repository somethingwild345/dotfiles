" Map leader to ,
let mapleader = ","

" Turn off search highlights
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Open init.vim
nnoremap <leader>ev :vsp $MYVIMRC<CR>

" Reload Vim config
nnoremap <leader>rv :so ~/.config/nvim/init.vim<CR>

" Create file under cursor
:map <leader>c :e <cfile><cr>

" Save current buffer with F2
nnoremap <F2> :w<CR>

" Switch Tabs
nnoremap <C-h>  :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
nnoremap <leader>w     :tabclose<CR>
