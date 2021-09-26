local lsp_progress = function()
    local messages = vim.lsp.util.get_progress_messages()
    if #messages == 0 then
        return ''
    end
    local status = {}
    for _, msg in pairs(messages) do
        table.insert(
            status,
            (msg.title or '') .. ' ' .. (msg.percentage or 0) .. '%%'
        )
    end
    local spinners = {
        '🌑',
        '🌒',
        '🌓',
        '🌔',
        '🌕',
        '🌖',
        '🌗',
        '🌘',
    }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners
    return table.concat(status, ' | ') .. ' ' .. spinners[frame + 1]
end

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

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'gruvbox-flat',
        component_separators = '',
        section_separators = '',
        disabled_filetypes = { 'nofile' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            { 'branch', icon = '' },
            {
                'diff',
                diff_color = {
                    added = { fg = '#a9b665' },
                    modified = { fg = '#e78a4e' },
                    removed = { fg = '#ea6962' },
                },
            },
            { 'diagnostics', sources = { 'nvim_lsp' } },
        },
        lualine_c = { { 'filename', file_status = true } },
        lualine_x = {
            lsp_client,
            lsp_progress,
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
    extensions = { 'nvim-tree', 'quickfix', 'toggleterm' },
})
