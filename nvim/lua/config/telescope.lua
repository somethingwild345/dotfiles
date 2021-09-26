local utils = require('utils')
local trouble = require('trouble.providers.telescope')

local actions = require('telescope.actions')

require('telescope').setup({
    defaults = {
        prompt_prefix = '🔭 ',
        selection_caret = '❯ ',
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<c-t>'] = trouble.open_with_trouble,
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
            n = {
                ['<c-t>'] = trouble.open_with_trouble,
            },
        },
        layout_strategy = 'horizontal',
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
            horizontal = {
                preview_width = 0,
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
        frecency = {
            show_scores = true,
            workspaces = {
                ['nvim'] = '/home/muhammad/.config/nvim',
                ['dot'] = '/home/muhammad/workspace/dotfiles',
                ['tasks'] = '/home/muhammad/Dropbox/neorg/tasks',
                ['notes'] = '/home/muhammad/Dropbox/neorg/notes',
            },
        },
    },
})

local telescope_map = function(key, provider)
    utils.map('n', '<C-s>' .. key, '<CMD>Telescope ' .. provider .. '<CR>')
end

telescope_map('b', 'buffers')
telescope_map('c', 'git_commits')
telescope_map(':', 'command_history')
telescope_map('f', 'find_files')
telescope_map('F', 'frecency')
telescope_map('g', 'git_files')
telescope_map('p', 'projects')
telescope_map('r', 'live_grep')
telescope_map('/', 'search_history')
