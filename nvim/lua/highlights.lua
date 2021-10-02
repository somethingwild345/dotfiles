local highlight = function(groupName, fg, bg, style)
    vim.cmd(
        'autocmd ColorScheme * highlight '
            .. groupName
            .. ' guifg='
            .. (fg or 'NONE')
            .. ' guibg='
            .. (bg or 'NONE')
            .. ' gui='
            .. (style or 'NONE')
            .. ' cterm='
            .. (style or 'NONE')
    )
end

local colors = {
    dark = '#282828',
    red = '#cc241d',
    green = '#98971a',
    yellow = '#d79921',
    blue = '#458588',
    purple = '#b16286',
    aqua = '#689d6a',
    light = '#a89984',
    grey = '#928374',
    bright_red = '#fb4934',
    bright_green = '#b8bb26',
    bright_yellow = '#fabd2f',
    bright_blue = '#83a598',
    bright_purple = '#d3869b',
    bright_aqua = '#8ec07c',
    bright_light = '#ebdbb2',
}

local M = {}

M.setup = function()
    -- Telescope
    highlight('TelescopeBorder', colors.grey)
    highlight('TelescopeSelection', 'NONE', colors.dark)
    highlight('TelescopeSlectionCaret', colors.green)

    -- Hop
    highlight('HopNextKey', colors.red, 'NONE', 'bold')
    highlight('HopNextKey1', colors.yellow, 'NONE', 'bold')
    highlight('HopNextKey2', colors.blue, 'NONE', 'bold')
    highlight('HopUnmatched', colors.grey)

    -- checkhealth
    highlight('healthError', colors.red)
    highlight('healthSuccess', colors.green)
    highlight('healthWarning', colors.yellow)

    -- nvim-cmp
    highlight('FloatBorder', colors.grey)
end

return M
