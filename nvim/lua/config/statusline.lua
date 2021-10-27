local colors = require('nightfox.colors').load()

-- local lsp_client = {
--     -- Lsp server name .
--     function()
--         local msg = {}
--         local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
--         local clients = vim.lsp.get_active_clients()

--         for _, client in ipairs(clients) do
--             local filetypes = client.config.filetypes
--             if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--                 table.insert(msg, client.name)
--             end
--         end

--         return table.concat(msg, ',')
--     end,
--     color = {
--         gui = 'bold',
--     },
-- }

local gutentags = {
    function()
        return vim.fn['gutentags#statusline']()
    end,
    color = {
        gui = 'bold',
    },
}

local head_tail = {
    function()
        return '▊'
    end,
    color = { fg = colors.blue },
    padding = 0,
}

local paddingRight = { left = 0, right = 1 }
require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'nightfox',
        component_separators = '',
        section_separators = '',
        disabled_filetypes = { 'nofile' },
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            head_tail,
            {
                'mode',
                color = {
                    gui = 'bold',
                },
            },
            {
                'filetype',
                icon_only = true,
                padding = { left = 1, right = 0 },
            },
            { 'filename', file_status = true, path = 1 },
            {
                'diagnostics',
                sources = { 'nvim_lsp' },
            },
            gutentags,
        },
        lualine_x = {
            -- lsp_client,
            {
                'branch',
                color = {
                    gui = 'bold',
                },
            },
            {
                'diff',
                padding = paddingRight,
                diff_color = {
                    added = { fg = colors.git.add },
                    modified = { fg = colors.git.change },
                    removed = { fg = colors.git.delete },
                },
            },
            { 'progress', padding = paddingRight },
            { 'location', padding = paddingRight },
            head_tail,
        },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = { 'quickfix', 'toggleterm', 'fugitive' },
})
