local g = vim.g

vim.opt.background = 'dark'

local catppuccino = require('catppuccino')
catppuccino.setup({
    colorscheme = 'dark_catppuccino', -- dark_catppuccino, soft_manilo, neon_latte, light_melya
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
        markdown = true,
        hop = true,
    },
})

vim.cmd([[colorscheme catppuccino]])
