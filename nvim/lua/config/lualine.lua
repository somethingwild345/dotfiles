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

local lsp_client = function()
    return {
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
        icon = ' ',
        cond = function()
            return #vim.lsp.get_active_clients() > 0
        end,
        color = {
            -- fg = '#0db9d7',
            -- gui = 'bold',
        },
    }
end

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'gruvbox-flat',
        padding = 1,
        section_separators = '',
        component_separators = '',
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            { 'branch', icon = '' },
        },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
        },
        lualine_x = {
            { 'diagnostics', sources = { 'nvim_lsp' } },
            lsp_client(),
            lsp_progress,
            'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
