local utils = require('utils')

require('hop').setup()

utils.map('n', '<leader>jw', ':HopWord<cr>', { noremap = true })
utils.map('n', '<leader>jl', ':HopLine<cr>', { noremap = true })
