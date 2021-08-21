local utils = require('utils')

require('trouble').setup({
    use_lsp_diagnostic_signs = true,
})

utils.map('n', '<leader>xx', '<cmd>Trouble<cr>')
utils.map('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>')
utils.map('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>')
utils.map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
utils.map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
utils.map('n', 'gR', '<cmd>Trouble lsp_references<cr>')
