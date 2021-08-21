local utils = require('utils')
local trouble = require('trouble.providers.telescope')

local actions = require('telescope.actions')

require('telescope').setup({
    defaults = {
        prompt_prefix = '🔭 ',
        selection_caret = ' ',
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<c-t>'] = trouble.open_with_trouble,
            },
            n = {
                ['<c-t>'] = trouble.open_with_trouble,
            },
        },
        layout_config = {
            horizontal = {
                preview_width = 0.5,
                mirror = false,
            },
        },
    },

    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

utils.map('n', '<c-p>', ':Telescope find_files<CR>')
utils.map('n', '<leader>g', ':Telescope live_grep<CR>')
utils.map('n', '<leader>c', ':Telescope git_commits<CR>')
utils.map('n', '<leader>b', ':Telescope buffers<CR>')
