local utils = require('utils')

require('auto-session').setup({
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
})

utils.map('n', '<leader>sl', ':RestoreSession<CR>')
