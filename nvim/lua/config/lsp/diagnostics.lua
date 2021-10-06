-- Automatically update diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        signs = true,
        update_in_insert = false,
        virtual_text = {
            source = 'always',
            prefix = '●',
            spacing = 5,
            severity_limit = 'Warning',
        },
        severity_sort = true,
    }
)

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- Show line diagnostics automatically in hover window
vim.cmd(
    [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
)

-- Go-to definition in a split window
local function goto_definition(split_cmd)
    local util = vim.lsp.util
    local log = require('vim.lsp.log')
    local api = vim.api

    local handler = function(_, method, result)
        if result == nil or vim.tbl_isempty(result) then
            local _ = log.info() and log.info(method, 'No location found')
            return nil
        end

        if split_cmd then
            vim.cmd(split_cmd)
        end

        if vim.tbl_islist(result) then
            util.jump_to_location(result[1])

            if #result > 1 then
                util.set_qflist(util.locations_to_items(result))
                api.nvim_command('copen')
                api.nvim_command('wincmd p')
            end
        else
            util.jump_to_location(result)
        end
    end

    return handler
end

vim.lsp.handlers['textDocument/definition'] = goto_definition('vsplit')
