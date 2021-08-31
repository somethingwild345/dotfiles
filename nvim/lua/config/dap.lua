local dap = require('dap')
local utils = require('utils')

utils.map('n', '<F5>', [[:lua require'dap'.continue()<CR>]])
utils.map('n', '<leader>dd', [[:lua require'dap'.toggle_breakpoint()<CR>]])
utils.map(
    'n',
    '<leader>dt',
    [[:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]]
)
utils.map(
    'n',
    '<leader>dl',
    [[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]]
)
utils.map('n', '<leader>dn', [[:lua require'dap'.step_over()<CR>]])
utils.map('n', '<leader>dp', [[:lua require'dap'.step_back()<CR>]])
utils.map('n', '<leader>d=', [[:lua require'dap'.step_into()<CR>]])
utils.map('n', '<leader>d-', [[:lua require'dap'.step_out()<CR>]])
utils.map('n', '<leader>dk', [[:lua require'dap'.up()<CR>]])
utils.map('n', '<leader>dj', [[:lua require'dap'.down()<CR>]])
utils.map('n', '<leader>dr', [[:lua require'dap'.repl.open()<CR>]])
