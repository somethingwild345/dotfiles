vim.opt.background = 'dark'
-- True color support
vim.opt.termguicolors = true

local nightfox = require('nightfox')

nightfox.setup({
    fox = 'nightfox', -- Which fox style should be applied
    transparent = false, -- Disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening :terminal
    styles = {
        comments = 'italic', -- Style that is applied to comments: see `highlight-args` for options
        functions = 'italic,bold', -- Style that is applied to functions: see `highlight-args` for options
        keywords = 'italic', -- Style that is applied to keywords: see `highlight-args` for options
        strings = 'NONE', -- Style that is applied to strings: see `highlight-args` for options
        variables = 'NONE', -- Style that is applied to variables: see `highlight-args` for options
    },
    inverse = {
<<<<<<< HEAD
        match_paren = false, -- Enable/Disable inverse highlighting for match parens
=======
        match_paren = true, -- Enable/Disable inverse highlighting for match parens
>>>>>>> c115808 (updates)
        visual = false, -- Enable/Disable inverse highlighting for visual selection
        search = false, -- Enable/Disable inverse highlights for search highlights
    },
    colors = {}, -- Override default colors
    hlgroups = {}, -- Override highlight groups
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
