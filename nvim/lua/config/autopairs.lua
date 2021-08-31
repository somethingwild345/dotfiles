local npairs = require('nvim-autopairs')

npairs.setup({})

require('nvim-autopairs.completion.cmp').setup({
    map_cr = false, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = false, -- auto select first item
})
