-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
local colors = {
    bg = '#282828',
    bg1 = '#32302f', -- cursor color
    bg2 = '#32302f',
    bg3 = '#45403d',
    bg4 = '#45403d',
    bg5 = '#5a524c',
    fg = '#d4be98',
    fg1 = '#ddc7a1',
    red = '#ea6962',
    orange = '#e78a4e',
    yellow = '#d8a657',
    green = '#a9b665',
    aqua = '#89b482',
    blue = '#7daea3',
    purple = '#d3869b',
    bg_red = '#ea6962',
    bg_green = '#a9b665',
    bg_yellow = '#d8a657',
    grey0 = '#7c6f64',
    grey1 = '#928374',
    grey2 = '#a89984',
    white = '#f2e5bc',
    black = '#1d2021',
    none = 'NONE',
    cyan = '#7daea3',
    pink = '#d3869b',
    link = '#89b482',
    cursor = '#ddc7a1',
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = 'gruvbox-flat',
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_v = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left({
    -- mode component
    function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.blue,
            i = colors.green,
            v = colors.yellow,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.purple,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.purple,
            Rv = colors.purple,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        vim.api.nvim_command(
            'hi! LualineMode guibg='
                .. mode_color[vim.fn.mode()]
                .. ' guifg='
                .. colors.bg
        )
        return ''
    end,
    color = 'LualineMode',
    padding = { right = 2, left = 2 },
})

ins_left({
    -- filesize component
    'filesize',
    cond = conditions.buffer_not_empty,
})

ins_left({
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.purple, gui = 'bold' },
})

ins_left({ 'location' })

ins_left({ 'progress', color = { fg = colors.fg, gui = 'bold' } })

ins_left({
    'diagnostics',
    sources = { 'nvim_lsp' },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
    function()
        return '%='
    end,
})

ins_left({
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
    icon = '  LSP:',
    color = { fg = colors.fg, gui = 'bold' },
})

ins_left({
    function()
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
    end,
})

-- Add components to right sections
ins_right({
    'o:encoding', -- option component same as &encoding in viml
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold' },
})

ins_right({
    'fileformat',
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colors.green, gui = 'bold' },
})

ins_right({
    'branch',
    icon = '',
    color = { fg = colors.purple, gui = 'bold' },
})

ins_right({
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = '柳 ', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
})

-- Now don't forget to initialize lualine
lualine.setup(config)
