local g = vim.g
local cmd = vim.cmd

-- g.gruvbox_bold = 1
-- g.gruvbox_italics = 0
-- -- g.gruvbox_plugin_hi_groups = 1

-- vim.cmd([[colorscheme gruvbox8]])

-- -- extra highlights
-- cmd([[highlight link CompeDocumentation NormalFloat]])

-- require('onedark').setup({
--     functionStyle = 'italic',
--     sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
--     hideInactiveStatusline = true,
--     -- colors = { hint = 'orange', error = '#ff0000' },
-- })

-- g.onedark_style = 'default'
g.disable_toggle_style = false
require('onedark').setup()
