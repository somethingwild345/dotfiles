local lsp_client = {
    -- Lsp server name .
    function()
        local msg = {}
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()

        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if
                filetypes
                and vim.fn.index(filetypes, buf_ft) ~= -1
                and client.name ~= 'null-ls'
            then
                table.insert(msg, client.name)
            end
        end

        return table.concat(msg, ',')
    end,
    color = {
        gui = 'bold',
    },
}

local gutentags = {
    function()
        return vim.fn['gutentags#statusline']()
    end,
    color = {
        gui = 'bold',
    },
}

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'zenflesh',
        component_separators = '',
        section_separators = '',
        disabled_filetypes = { 'nofile' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            {
                'diff',
                diff_color = {
                    added = { fg = '#819B69' },
                    modified = { fg = '#B77E64' },
                    removed = { fg = '#DE6E7C' },
                },
            },
        },
        lualine_c = { { 'filename', file_status = true }, gutentags },
        lualine_x = {
            lsp_client,
            { 'diagnostics', sources = { 'nvim_lsp' } },
            'encoding',
            { 'fileformat', icons_enabled = false },
            'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
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
    extensions = { 'quickfix' },
})
