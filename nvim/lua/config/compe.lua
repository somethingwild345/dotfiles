local utils = require('utils')

-- obselote for nvim-compe
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.cmd([[set shortmess+=c]])

require('compe').setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = {
        border = 'single',
    },

    source = {
        path = true,
        buffer = true,
        calc = false,
        nvim_lsp = true,
        nvim_lua = false,
        vsnip = false,
        ultisnips = false,
        luasnip = true,
        spell = true,
        neorg = true,
    },
})

local t = utils.t

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local luasnip = require('luasnip')

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t('<C-n>')
    elseif luasnip.expand_or_jumpable() then
        return t("<cmd>lua require'luasnip'.jump(1)<Cr>")
    elseif check_back_space() then
        return t('<Tab>')
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t('<C-p>')
    elseif luasnip.jumpable(-1) then
        return t("<cmd>lua require'luasnip'.jump(-1)<CR>")
    else
        return t('<S-Tab>')
    end
end

utils.map('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
utils.map('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
utils.map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
utils.map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

require('nvim-autopairs.completion.compe').setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = true, -- auto select first item
})

local opts = { expr = true }
utils.map('i', '<c-space>', 'compe#complete()', opts)
utils.map('i', '<c-e>', [[compe#close('<C-e>')]], opts)
utils.map('i', '<c-f>', [[compe#scroll({ 'delta': +4 })]], opts)
utils.map('i', '<c-b>', [[compe#scroll({ 'delta': -4 })]], opts)
