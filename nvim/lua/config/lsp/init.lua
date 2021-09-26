local lsp_config = require('lspconfig')
local nls_config = require('config.lsp.null-ls')
local ts_utils_config = require('config.lsp.ts-utils')
local sumneko_lua_config = require('config.lsp.sumneko_lua')

require('config.lsp.diagnostics')

local border = 'rounded'

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
            border = border,
        },
        doc_lines = 2,
        hint_prefix = '🐧 ',
        fix_pos = function(signatures, lspclient)
            if
                signatures[1].activeParameter >= 0
                and #signatures[1].parameters == 1
            then
                return false
            end
            if lspclient.name == 'sumneko_lua' then
                return true
            end
            return false
        end,
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
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

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
        '<space>f',
        '<cmd>lua vim.lsp.buf.formatting()<CR>',
        opts
    )
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
capabilities.textDocument.completion.completionItem.documentationFormat = {
    'markdown',
    'plaintext',
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
    true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

local function make_config(server)
    local config = {
        on_attach = function(client, bufnr)
            -- prevent actual LSP clients from providing formatting
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
    }

    if server == 'tsserver' then
        config.init_options = {
            preferences = {
                importModuleSpecifierEnding = 'minimal',
            },
        }
    end

    if server == 'lua' then
        config.settings = sumneko_lua_config
    end

    return config
end

local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
    local config = make_config(server)

    server:setup(config)
    vim.cmd([[ do User LspAttachBuffers ]])
end)

-- null-ls
require('null-ls').config(nls_config)
lsp_config['null-ls'].setup(make_config('null-ls'))

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
