local utils = require('utils')

local function copy_to_clipboard(files)
    files = table.concat(files, '\n')
    vim.fn.setreg('+', files)
    print(files:gsub('\n', ', ') .. 'copied to register')
end

require('nnn').setup({
    explorer = {
        width = 30,
        session = 'shared',
    },
    picker = {
        cmd = 'tmux new-session nnn -Pp',
        style = { border = vim.g.border },
    },
    replace_netrw = 'picker',
    mappings = {
        { '<C-t>', 'tabedit' }, -- open file(s) in tab
        { '<C-s>', 'split' }, -- open file(s) in split
        { '<C-v>', 'vsplit' }, -- open file(s) in vertical split
        { '<C-y>', copy_to_clipboard }, -- copy file(s) to clipboard
    },
})

utils.map('n', '<leader>n', ':NnnExplorer<CR>')
utils.map('n', '<leader>N', ':NnnPicker %:p:h<CR>')
