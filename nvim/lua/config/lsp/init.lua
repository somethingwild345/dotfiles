local lsp_config = require('lspconfig')
local nls_config = require('config.lsp.null-ls')
local ts_utils_config = require('config.lsp.ts-utils')
local sumneko_lua_config = require('config.lsp.sumneko_lua')

require('config.lsp.diagnostics')
-- require('config.lsp.kind').setup()

local border = 'single'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- extra tools for typescript
    if client.name == 'tsserver' or client.name == 'typescript' then
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
            border = border,
        },
        hint_prefix = '🌌 ',
        hint_scheme = 'String',
        hi_parameter = 'IncSearch',
    })

    -- Mappings.
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
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
    buf_set_keymap('n', 'grr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap(
        'n',
        '<C-k>',
        '<cmd>lua vim.lsp.buf.signature_help()<CR>',
        opts
    )

    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    buf_set_keymap(
        'n',
        '<space>ca',
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

-- Load LSP installed servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
local completionItem = capabilities.textDocument.completion.completionItem
completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = { valueSet = { 1 } }
completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

local function make_config()
    return {
        on_attach = function(client, bufnr)
            -- prevent actual LSP clients from providing formatting
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
    }
end

-- null-ls
require('null-ls').config(nls_config)
lsp_config['null-ls'].setup(make_config())

local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
    local config = make_config()

    if server == 'lua' then
        config.settings = sumneko_lua_config
    end

    server:setup(config)
    vim.cmd([[ do User LspAttachBuffers ]])
end)

-- AutoFormat
vim.cmd([[
augroup AutoFormat
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
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
