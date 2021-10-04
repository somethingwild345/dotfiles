-- local g = vim.g
local opt = vim.opt

opt.background = 'dark'
-- True color support
opt.termguicolors = true

local nightfox = require('nightfox')

nightfox.setup({
    fox = 'nightfox',
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'italic,bold',
        strings = 'NONE',
        variables = 'NONE',
    },
    inverse = {
        match_paren = false,
        visual = false,
        search = false,
    },
    colors = {},
    hlgroups = {},
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
