local utils = require('utils')

require('bufferline').setup({
    options = {
        numbers = 'ordinal',
        show_buffer_close_icons = false,
        always_show_bufferline = false,
        veparator_style = 'slant',
    },
})

-- Switch buffers
utils.map('n', '[b', ':BufferLineCyclePrev<CR>')

utils.map('n', ']b', ':BufferLineCycleNext<CR>')

utils.map('n', '<leader>w', ':BufferLinePickClose<CR>')
