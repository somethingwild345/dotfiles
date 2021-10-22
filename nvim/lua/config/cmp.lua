local cmp = require('cmp')
local luasnip = require('luasnip')

vim.opt.completeopt = 'menuone,noselect'
vim.cmd([[set shortmess+=c]])

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match('%s')
            == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    documentation = {
        border = vim.g.border,
        winhighlight = 'FloatBorder:FloatBorder',
    },
    preselect = cmp.PreselectMode.None,
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {
            'i',
            's',
        }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
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
        {
            name = 'buffer',
            opts = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = 'path' },
        { name = 'tags' },
        { name = 'orgmode' },
    },

    formatting = {
        format = function(entry, vim_item)
            -- load lspkind icons
            vim_item.kind = string.format(
                '%s %s',
                require('config.lsp.kind').icons[vim_item.kind],
                vim_item.kind
            )

            -- set a name for each source
            vim_item.menu = ({
                buffer = '[Buf]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
            })[entry.source.name]
            return vim_item
        end,
    },
})
vim.cmd(
    [[autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }]]
)
