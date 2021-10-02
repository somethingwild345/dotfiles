local g = vim.g

vim.opt.background = 'light'

local catppuccino = require('catppuccino')
catppuccino.setup({
    colorscheme = 'light_melya',
    term_colors = false,
    integrations = {
        lsp_trouble = true,
        gitsigns = true,
        telescope = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        bufferline = true,
        markdown = false,
        hop = true,
    },
})

vim.cmd([[colorscheme catppuccino]])
