local cmp = require('cmp')

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

local feedkey = function(key)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(key, true, true, true),
        'n',
        true
    )
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    documentation = {
        border = vim.g.border,
        -- winhighlight = 'FloatBorder:NormalFloat',
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
            if vim.fn.pumvisible() == 1 then
                feedkey('<C-n>')
            elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
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
            if vim.fn.pumvisible() == 1 then
                feedkey('<C-p>')
            elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
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
        { name = 'buffer' },
        { name = 'path' },
        { name = 'tags' },
        { name = 'neorg' },
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
