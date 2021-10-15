local nls = require('null-ls')

local defaults = {
    -- debounce = 250,
    save_after_format = false,
    sources = {
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.gofumpt,
        nls.builtins.formatting.nginx_beautifier,

        nls.builtins.code_actions.gitsigns,

        nls.builtins.diagnostics.shellcheck,
        nls.builtins.diagnostics.markdownlint,
    },
}

return defaults
