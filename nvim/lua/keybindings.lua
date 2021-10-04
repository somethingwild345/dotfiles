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

_G.save_session = function()
    utils.log('session saved!')
    return t('<cmd>mksession!<CR>')
end

-- Save session
utils.map('n', '<space>ss', 'v:lua.save_session()', { expr = true })

-- load session
utils.map('n', '<space>sl', '<CMD>source Session.vim<CR>', { expr = true })

-- move lines up/down
utils.map('n', '<A-j>', ':m .+1<CR>==')
utils.map('n', '<A-k>', ':m .-2<CR>==')
utils.map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
utils.map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
utils.map('v', '<A-j>', ":m '>+1<CR>gv=gv")
utils.map('v', '<A-k>', ":m '<-2<CR>gv=gv")

--Remap for dealing with word wrap
-- utils.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- utils.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- updat plugins
utils.map('n', '<space>uu', ':PackerSync<CR>')
-- toggle symbols
utils.map('n', '<leader>ss', ':SymbolsOutline<CR>')
-- nnn
utils.map('n', '<leader>nn', ':NnnPicker<CR>')
