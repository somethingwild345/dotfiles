local kommentary_config = require('kommentary.config')

kommentary_config.configure_language('default', {
    prefer_single_line_comments = true,
})

local filetypes = {
    'html',
    'javascriptreact',
    'typescriptreact',
    'svelte',
    'vue',
    'markdown',
}

for _, ft in pairs(filetypes) do
    kommentary_config.configure_language(ft, {
        single_line_comment_string = 'auto',
        multi_line_comment_strings = 'auto',
        hook_function = function()
            require('ts_context_commentstring.internal').update_commentstring()
        end,
    })
end
