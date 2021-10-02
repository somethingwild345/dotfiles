-- improve startup time
pcall(require, 'impatient')
require('config.packer_compiled')

-- basic configuration
require('settings')

-- keybindings
require('keybindings')

-- load only after entering vim ui
vim.defer_fn(function()
    -- package manager
    require('plugins')
end, 0)
