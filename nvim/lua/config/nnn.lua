local utils = require('utils')

local function copy_to_clipboard(lines)
    local joined_lines = table.concat(lines, '\n')
    vim.fn.setreg('+', joined_lines)
end

require('nnn').setup({
    command = 'NNN_TRASH=1 nnn -eoC',
    layout = { window = { width = 0.8, height = 0.7, border = vim.g.border } },
    session = 'local',
    replace_netrw = true,
    set_default_mappings = false,
    action = {
        ['<c-t>'] = 'tab split',
        ['<c-s>'] = 'split',
        ['<c-v>'] = 'vsplit',
        ['<c-o>'] = copy_to_clipboard,
    },
})

utils.map('n', '<leader>nn', ':NnnPicker<CR>')
