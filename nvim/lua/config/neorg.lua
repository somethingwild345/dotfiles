require('neorg').setup({
    -- Tell Neorg what modules to load
    load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.norg.completion'] = {
            config = {
                engine = 'nvim-cmp', -- We current support nvim-compe and nvim-cmp only
            },
        },
        ['core.norg.concealer'] = {}, -- Allows for use of icons
        ['core.norg.dirman'] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    notes = '~/Dropbox/neorg/notes',
                    tasks = '~/Dropbox/neorg/tasks',
                },
                -- Automatically detect whenever we have entered a subdirectory of a workspace
                autodetect = true,
            },
        },
    },
    hook = function()
        -- The code that we will showcase below goes here
        local neorg_leader = '<Leader>'

        local neorg_callbacks = require('neorg.callbacks')
        neorg_callbacks.on_event(
            'core.keybinds.events.enable_keybinds',
            function(_, keybinds)
                -- Map all the below keybinds only when the "norg" mode is active
                keybinds.map_event_to_mode('norg', {
                    n = { -- Bind keys in normal mode

                        -- Keys for managing TODO items and setting their states
                        { 'gtd', 'core.norg.qol.todo_items.todo.task_done' },
                        { 'gtu', 'core.norg.qol.todo_items.todo.task_undone' },
                        { 'gtp', 'core.norg.qol.todo_items.todo.task_pending' },
                        {
                            'gtc',
                            'core.norg.qol.todo_items.todo.task_cycle',
                        },
                    },
                }, {
                    silent = true,
                    noremap = true,
                })
            end
        )
    end,
})
