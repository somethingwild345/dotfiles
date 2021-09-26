local g = vim.g
local map = require('utils').map

g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
g.nvim_tree_quit_on_open = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_window_picker_exclude = {
    filetype = {
        'nofile',
        'notify',
        'packer',
        'qf',
    },
    buftype = {
        'terminal',
    },
}

require('nvim-tree').setup()

map('n', '<Space>n', '<CMD>NvimTreeToggle<CR>')
