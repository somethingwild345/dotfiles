require('indent_blankline').setup({
    buftype_exclude = { 'terminal', 'nofile' },
    filetype_exclude = {
        'help',
        'dashboard',
        'packer',
        'man',
        'lspinfo',
        'diagnosticpopup',
    },
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    show_end_of_line = true,
    space_char_blankline = ' ',
    use_treesitter = true,
})

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = '99999'
