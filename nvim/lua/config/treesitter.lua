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
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autotag = {
        filetypes = {
            'html',
            'javascriptreact',
            'typescriptreact',
            'svelte',
            'vue',
        },
    },
    matchup = {
        enable = true,
    },
})
