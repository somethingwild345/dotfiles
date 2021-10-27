local lsp_config = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local lsp_opts = require('config.lsp.lsp-opts')
local utils = require('utils')

require('config.lsp.diagnostics')
require('config.lsp.null-ls').setup()

-- install LSP servers
local servers = {
    'eslint',
    'graphql',
    'sumneko_lua',
    'tsserver',
    'jsonls',
    'dockerls',
    'yamlls',
}

for _, name in pairs(servers) do
    local ok, server = lsp_installer.get_server(name)
    -- Check that the server is supported in nvim-lsp-installer
    if ok then
        if not server:is_installed() then
            print('Installing ' .. name)
            server:install()
        end
    end
end

lsp_installer.on_server_ready(function(server)
    server:setup(
        lsp_opts.server_opts[server.name]
                and lsp_opts.server_opts[server.name]()
            or lsp_opts.default_opts
    )
    vim.cmd([[ do User LspAttachBuffers ]])
end)

-- null-ls
lsp_config['null-ls'].setup(lsp_opts.default_opts)

vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

utils.map(
    'n',
    '<A-n>',
    '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>'
)
utils.map(
    'n',
    '<A-p>',
    '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>'
)

-- AutoFormat
vim.cmd([[
augroup AutoFormat
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1200)
augroup end
]])

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
    if msg:match('exit code') then
        return
    end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({ { msg } }, true, {})
    end
end
