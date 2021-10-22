local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = { 'src/parser.c', 'src/scanner.cc' },
    },
    filetype = 'org',
}

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'comment',
        'dockerfile',
        'go',
        'gomod',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'typescript',
        'yaml',
        'org',
    },
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = { 'org' },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = '.',
            scope_incremental = 'grc',
            node_decremental = ';',
        },
    },
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
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
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
