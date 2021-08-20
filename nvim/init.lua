--don't write to the ShaDa file on startup
vim.opt.shadafile = 'NONE'

local modules = { 'general', 'keys' }

local utils = require('utils')
utils.load(modules)

-- don't load plugin immediately, since we have package_compiled
vim.defer_fn(function()
    pcall(require, 'plugins')
end, 0)

-- load shadafile now
vim.opt.shadafile = ''
