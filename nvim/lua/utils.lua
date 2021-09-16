_G.dump = function(...)
    print(vim.inspect(...))
end

local M = {}

M.map = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.load = function(modules)
    for _, m in pairs(modules) do
        pcall(require, m)
    end
end

function M.log(msg, hl, name)
    name = name or 'Neovim'
    hl = hl or 'Todo'
    vim.api.nvim_echo({ { name .. ':', hl }, { ' ' .. msg } }, true, {})
end

function M.warn(msg, name)
    M.log(msg, 'LspDiagnosticsDefaultWarning', name)
end

function M.error(msg, name)
    M.log(msg, 'LspDiagnosticsDefaultError', name)
end

function M.info(msg, name)
    M.log(msg, 'LspDiagnosticsDefaultInformation', name)
end

M.t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.lsp_config()
    local ret = {}
    for _, client in pairs(vim.lsp.get_active_clients()) do
        ret[client.name] = {
            root_dir = client.config.root_dir,
            settings = client.config.settings,
        }
    end
    dump(ret)
end

return M
