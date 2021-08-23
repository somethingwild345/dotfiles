local lsp_progress = function()
    local messages = vim.lsp.util.get_progress_messages()
    if #messages == 0 then
        return
    end
    local status = {}
    for _, msg in pairs(messages) do
        table.insert(
            status,
            (msg.title or '') .. ' ' .. (msg.percentage or 0) .. '%%'
        )
    end
    local spinners = {
        '⠋',
        '⠙',
        '⠹',
        '⠸',
        '⠼',
        '⠴',
        '⠦',
        '⠧',
        '⠇',
        '⠏',
    }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners
    return table.concat(status, ' | ') .. ' ' .. spinners[frame + 1]
end

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'onedark',
        padding = 1,
        section_separators = {},
        component_separators = { '|' },
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            { 'branch', icon = '' },
            {
                'diff',
                condition = function()
                    return vim.fn.winwidth(0) > 80
                end,
            },
        },
        lualine_c = {
            'filename',
        },
        lualine_x = {
            lsp_progress,
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
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
