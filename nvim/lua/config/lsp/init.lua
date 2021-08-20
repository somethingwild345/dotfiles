local lspconfig = require('lspconfig')
local nls_config = require('config.lsp.null-ls')
local ts_utils_config = require('config.lsp.ts-utils')
local sumneko_lua_config = require('config.lsp.sumneko_lua')
local utils = require('utils')

require('config.lsp.diagnostics')
require('config.lsp.kind').setup()

local border = 'single'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- extra tools for typescript
    if client.name == 'tsserver' then
        local ts_utils = require('nvim-lsp-ts-utils')

        ts_utils.setup(ts_utils_config)
        -- required to fix code action ranges
        ts_utils.setup_client(client)

        -- keymaps for typescript only
        local opts = { silent = true }
        vim.api.nvim_buf_set_keymap(
            bufnr,
            'n',
            'go',
            ':TSLspOrganize<CR>',
            opts
        )
    end

    -- Floating windows with borders
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = border }
    )
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = border }
    )

    -- Show signature while typing
    require('lsp_signature').on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = 'single',
        },
        hint_prefix = '🌌 ',
    })

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap(
        'n',
        'gy',
        '<cmd>lua vim.lsp.buf.type_definition()<CR>',
        opts
    )
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    buf_set_keymap(
        'n',
        '<space>ac',
        '<cmd>lua vim.lsp.buf.code_action()<CR>',
        opts
    )

    buf_set_keymap(
        'n',
        '[d',
        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
        opts
    )
    buf_set_keymap(
        'n',
        ']d',
        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
        opts
    )
end

-- Use LSP snippet
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

-- Setyp servers
local servers = {
    bashls = {},
    cssls = {},
    dockerls = {},
    html = {},
    gopls = {},
    graphql = {},
    jsonls = {},
    ['null-ls'] = {},
    prismals = {},
    tsserver = {},
    sumneko_lua = require('lua-dev').setup({
        -- add any options here, or leave empty to use the default settings
        lspconfig = sumneko_lua_config,
    }),
    vimls = {},
    yamlls = {},
}

require('null-ls').config(nls_config)

for server, config in pairs(servers) do
    lspconfig[server].setup(vim.tbl_deep_extend('force', {
        on_attach = function(client, bufnr)
            -- prevent actual LSP clients from providing formatting
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        flags = { debounce_text_changes = 150 },
    }, config))
    -- throw error if server not installed
    local cfg = lspconfig[server]
    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
        utils.error(server .. ': cmd not found: ' .. vim.inspect(cfg.cmd))
    end
end

-- AutoFormat
vim.cmd([[
augroup AutoFormat
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
augroup end
]])
