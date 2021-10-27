local utils = require('utils')
local t = utils.t

-- Map leader to ,
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- disable F1
utils.map('n', '<F1>', '<Esc>')
utils.map('i', '<F1>', '<Esc>')
utils.map('v', '<F1>', '<Esc>')

-- Turn off search highlights
utils.map('n', '<leader><space>', ':nohlsearch<CR>')

-- Save current buffer with F2
utils.map('n', '<F2>', ':w<CR>')
utils.map('i', '<F2>', '<Esc>:w<CR>')

_G.save_session = function()
    utils.log('session saved!')
    return t('<cmd>mksession!<CR>')
end

-- move lines up/down
utils.map('n', '<A-j>', ':m .+1<CR>==')
utils.map('n', '<A-k>', ':m .-2<CR>==')
utils.map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
utils.map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
utils.map('v', '<A-j>', ":m '>+1<CR>gv=gv")
utils.map('v', '<A-k>', ":m '<-2<CR>gv=gv")

--Remap for dealing with word wrap
utils.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
utils.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- -- terminal window moves
-- utils.map('n', '<space>tt', ':sp | term<cr>i')
-- utils.map('t', '<Esc>', [[<C-\><C-n>]])
-- utils.map('t', '<C-w>w', [[<C-\><C-n><C-w>w]])
-- utils.map('t', '<C-w>k', [[<C-\><C-n><C-w>k]])
-- utils.map('t', '<C-w>j', [[<C-\><C-n><C-w>j]])
-- utils.map('t', '<C-w>l', [[<C-\><C-n><C-w>l]])
-- utils.map('t', '<C-w>h', [[<C-\><C-n><C-w>h]])

-- switch between quickfix/loclist items
utils.map('n', '[q', ':cprevious<CR>')
utils.map('n', ']q', ':cnext<CR>')
utils.map('n', '[l', ':lprevious<CR>')
utils.map('n', ']l', ':lnext<CR>')

-- updat plugins
utils.map('n', '<space>uu', ':PackerSync<CR>')
-- toggle symbols
utils.map('n', '<leader>ss', ':SymbolsOutline<CR>')
