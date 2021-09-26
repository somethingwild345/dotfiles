local utils = require('utils')

require('bufferline').setup({
    options = {
        offsets = {
            {
                filetype = 'NvimTree',
                text = function()
                    return vim.fn.getcwd()
                end,
                highlight = 'Directory',
                text_align = 'left',
            },
        },
        numbers = 'ordinal',
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        separator_style = 'thin',
    },
})

-- Switch buffers
utils.map('n', '[b', ':BufferLineCyclePrev<CR>')

utils.map('n', ']b', ':BufferLineCycleNext<CR>')

utils.map('n', '<leader>w', ':BufferLinePickClose<CR>')
