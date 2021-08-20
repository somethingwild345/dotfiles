local utils = require('utils')
local t = utils.t

_G.reload_configs = function()
    local reload = require('plenary.reload')
    -- reload each module
    local modules = { 'plugins', 'keys', 'general' }
    for _, m in pairs(modules) do
        reload.reload_module(m, true)
    end

    -- Make sure all open buffers are saved
    vim.cmd('silent wa')
    -- Execute our vimrc lua file again to add back our maps
    dofile(vim.fn.stdpath('config') .. '/init.lua')

    utils.info('Neovim Reloaded!')
end

-- Map leader to ,
vim.g.mapleader = ','

-- Turn off search highlights
utils.map('n', '<leader><space>', ':nohlsearch<CR>')

-- Save current buffer with F2
utils.map('n', '<F2>', ':w<CR>')

-- Open init.lua
utils.map('n', '<space>ev', ':vs ~/.config/nvim/init.lua<CR>')

-- Reload init.lua
utils.map('n', '<space>rv', 'v:lua.reload_configs()', { expr = true })

_G.save_session = function()
    utils.log('Session Saved!')
    return t('<cmd>mksession!<CR>')
end

-- Save session
utils.map('n', '<space>ss', 'v:lua.save_session()', { expr = true })

-- load session
utils.map('n', '<space>sl', '<CMD>source Session.vim<CR>', { expr = true })

-- nvim tree toggle
utils.map('n', '<leader>n', ':NvimTreeToggle<CR>')

-- vim-tmux-navigator
vim.g.tmux_navigator_no_mappings = 1

vim.cmd([[
noremap <silent> <m-h> :TmuxNavigateLeft<cr>
noremap <silent> <m-j> :TmuxNavigateDown<cr>
noremap <silent> <m-k> :TmuxNavigateUp<cr>
noremap <silent> <m-l> :TmuxNavigateRight<cr>
noremap <silent> <m-/> :TmuxNavigatePrevious<cr>
]])
