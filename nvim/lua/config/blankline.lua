require('indent_blankline').setup({
    buftype_exclude = { 'terminal', 'nofile' },
    filetype_exclude = {
        'help',
        'dashboard',
        'packer',
        'man',
        'lspinfo',
        'diagnosticpopup',
        'neogitstatus',
        'NvimTree',
        'Trouble',
    },
    char = '│',
    -- space_char_blankline = ' ',
    -- show_end_of_line = true,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    use_treesitter = true,
})

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = '99999'
