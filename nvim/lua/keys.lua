local utils = require('utils')
local t = utils.t

-- Map leader to ,
vim.g.mapleader = ','

-- Turn off search highlights
utils.map('n', '<leader><space>', ':nohlsearch<CR>')

-- Save current buffer with F2
utils.map('n', '<F2>', ':w<CR>')

_G.save_session = function()
    utils.log('Session Saved!')
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

-- update plugins
utils.map('n', '<space>uu', ':PackerSync<CR>')
