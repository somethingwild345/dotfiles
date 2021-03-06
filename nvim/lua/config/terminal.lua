local utils = require('utils')

require('toggleterm').setup({
    size = 15,
    open_mapping = [[<space>tt]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    persist_size = true,
    direction = 'horizontal',
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-w>h', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-w>j', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-w>k', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-w>l', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = 'lazygit',
    direction = 'float',
    float_opts = {
        border = vim.g.border,
    },
    hidden = true,
})

function _G.lazygit_toggle()
    lazygit:toggle()
end

utils.map('n', '<leader>g', '<cmd>lua lazygit_toggle()<CR>')
