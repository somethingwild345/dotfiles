local g = vim.g

vim.opt.background = 'dark'

g.gruvbox_flat_style = 'hard'
g.gruvbox_italic_functions = true
g.gruvbox_sidebars = { 'qf', 'terminal', 'packer', 'NvimTree' }

-- Load the colorscheme
vim.cmd([[colorscheme gruvbox-flat]])
