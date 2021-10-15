vim.opt.shadafile = 'NONE'

-- improve startup time
pcall(require, 'impatient')

-- basic configuration
require('settings')

-- keybindings
require('keybindings')

-- package manager
require('plugins')

vim.opt.shadafile = ''
