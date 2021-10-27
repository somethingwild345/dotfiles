local sumneko_lua_config = require('config.lsp.sumneko_lua')
local border = vim.g.border

local M = {}

local on_attach = function(client, bufnr)
    -- Floating windows with borders
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = border }
    )
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = border }
    )

    require('illuminate').on_attach(client)

    -- Mappings.
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap(
        'n',
        '<C-k>',
        '<cmd>lua vim.lsp.buf.signature_help()<CR>',
        opts
    )
    buf_set_keymap(
        'n',
        '<space>wa',
        '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
        opts
    )
    buf_set_keymap(
        'n',
        '<space>wr',
        '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        opts
    )
    buf_set_keymap(
        'n',
        '<space>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        opts
    )
    buf_set_keymap(
        'n',
        'gy',
        '<cmd>lua vim.lsp.buf.type_definition()<CR>',
        opts
    )
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
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
    buf_set_keymap(
        'n',
        '<leader>xw',
        '<cmd>lua vim.lsp.diagnostic.set_qflist()<CR>',
        opts
    )
    buf_set_keymap(
        'n',
        '<leader>xd',
        '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
        opts
    )
    buf_set_keymap(
        'n',
        '<space>f',
        '<cmd>lua vim.lsp.buf.formatting()<CR>',
        opts
    )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local default_opts = {
    on_attach = function(client, bufnr)
        -- prevent actual LSP clients from providing formatting
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    -- flags = { debounce_text_changes = 500 },
}

M.default_opts = default_opts

M.server_opts = {
    ['tsserver'] = function()
        default_opts.init_options = {
            preferences = {
                importModuleSpecifierEnding = 'minimal',
            },
        }

        return default_opts
    end,
    ['lua'] = function()
        default_opts.settings = sumneko_lua_config

        return default_opts
    end,
}

return M
