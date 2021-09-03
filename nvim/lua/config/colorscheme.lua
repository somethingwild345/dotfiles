local g = vim.g
local opt = vim.opt

opt.background = 'dark'

g.tokyonight_style = 'night'
g.tokyonight_italic_functions = true
g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }
g.tokyonight_hide_inactive_statusline = true

-- g.tokyonight_colors = { hint = 'orange', error = '#ff0000' }

-- Load the colorscheme
vim.cmd([[colorscheme tokyonight]])
