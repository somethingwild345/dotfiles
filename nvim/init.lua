require('impatient')

local modules = { 'general', 'keys' }

local utils = require('utils')
utils.load(modules)

-- don't load plugin immediately, since we have package_compiled
vim.defer_fn(function()
    pcall(require, 'plugins')
end, 0)
