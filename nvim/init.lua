-- improve startup time
local ok, impatient = pcall(require, 'impatient')
if ok then
    impatient.enable_profile()
end

-- basic configuration
require('settings')

-- keybindings
require('keybindings')

-- package manager
require('plugins')
