local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg',
        files = { 'src/parser.c', 'src/scanner.cc' },
        branch = 'main',
    },
}

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'c',
        'comment',
        'cpp',
        'css',
        'dockerfile',
        'go',
        'gomod',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'scss',
        'typescript',
        'vim',
        'vue',
        'yaml',
        'norg',
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
            },
        },
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
        },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    matchup = {
        enable = true,
    },
})
