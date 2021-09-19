require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'c',
        'comment',
        'cpp',
        'css',
        'dot',
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
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
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
    autotag = {
        enable = true,
        filetypes = {
            'html',
            'javascriptreact',
            'typescriptreact',
            'svelte',
            'vue',
        },
    },
})
