local utils = require('utils')

require('bufferline').setup({
    options = {
        numbers = 'ordinal',
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        separator_style = 'thin',
    },
})

-- Switch buffers
utils.map('n', '[b', ':BufferLineCyclePrev<CR>')
utils.map('n', ']b', ':BufferLineCycleNext<CR>')
-- Close buffers
utils.map('n', '<leader>w', ':BufferLinePickClose<CR>')
