vim.opt.background = 'dark'
-- True color support
vim.opt.termguicolors = true

local g = vim.g
g.zenbones_lightness = 'dim'
g.zenflesh_darkness = 'warm'
g.zenbones_solid_vert_split = true
g.zenflesh_solid_vert_split = true
g.zenbones_darken_noncurrent_window = true
g.zenflesh_lighten_noncurrent_window = true
g.zenbones_compat = 1

vim.cmd([[colorscheme zenflesh]])
