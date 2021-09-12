local cmp = require('cmp')
local utils = require('utils')
local luasnip = require('luasnip')
local t = utils.t

vim.opt.completeopt = 'menuone,noselect'
vim.cmd([[set shortmess+=c]])

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

cmp.setup({

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    documentation = {
        border = 'single',
    },
    preselect = cmp.PreselectMode.None,
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<tab>'] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t('<C-n>'), 'n')
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
            elseif check_back_space() then
                vim.fn.feedkeys(t('<tab>'), 'n')
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
        ['<S-tab>'] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t('<C-p>'), 'n')
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'cmp_tabnine' },
        { name = 'buffer' },
        { name = 'orgmode' },
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                cmp_tabnine = '[T9]',
            })[entry.source.name]
            return vim_item
        end,
    },
})
