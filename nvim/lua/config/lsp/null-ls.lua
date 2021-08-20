local nls = require('null-ls')

local defaults = {
    debounce = 150,
    save_after_format = false,
    sources = {
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.fish_indent,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.nginx_beautifier,

        nls.builtins.diagnostics.shellcheck,
        nls.builtins.diagnostics.markdownlint,
    },
}

return defaults
