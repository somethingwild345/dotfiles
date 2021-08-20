local lsp_config = require('lspconfig')

local eslint = {
    lintCommand = './node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}',
    lintIgnoreExitCode = true,
    lintStdin = true,
}

local prettier = {
    formatCommand = './node_modules/.bin/prettier --stdin --stdin-filepath ${INPUT}',
    formatStdin = true,
}

local fish = { formatCommand = 'fish_indent', formatStdin = true }

local luafmt = {
    formatCommand = 'lua-format -i --double-quote-to-single-quote --indent-width=2',
    formatStdin = true,
}

local markdownLint = {
    lintCommand = 'markdownlint --fix ${INPUT}',
    lintFormats = { '%f:%l:%c MD%n/%*[^ ] %m', '%f:%l MD%n/%*[^ ] %m' },
    lintStdin = true,
}

local bashLint = {
    lintCommand = 'shellcheck -f gcc -x -',
    lintFormats = { '%f:%l:%c: %t%*[^:]: %m [SC%n]' },
    lintStdin = true,
}

local bashFmt = {
    formatCommand = 'shfmt -ln bash -i 2 -bn -ci -sr -kp',
    formatStdin = true,
}

local efm_config = os.getenv('HOME')
    .. '/.config/nvim/lua/config/lsp/efm/config.yml'
local efm_log_dir = '/tmp/'
local efm_root_markers = {
    'package.json',
    '.git/',
    '.eslintrc.js',
    '.eslintrc',
}

local efm_languages = {
    markdown = { markdownLint, prettier },
    javascript = { eslint, prettier },
    javascriptreact = { eslint, prettier },
    typescript = { eslint, prettier },
    typescriptreact = { eslint, prettier },
    css = { prettier },
    scss = { prettier },
    sass = { prettier },
    less = { prettier },
    graphql = { prettier },
    vue = { prettier },
    html = { prettier },
    lua = { luafmt },
    fish = { fish },
    sh = { bashLint, bashFmt },
}

local M = {
    cmd = {
        'efm-langserver',
        '-c',
        efm_config,
        '-logfile',
        efm_log_dir .. 'efm.log',
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'lua',
        'fish',
        'sh',
        'markdown',
        'css',
        'scss',
        'less',
        'sass',
        'graphql',
        'vue',
        'html',
    },
    root_dir = lsp_config.util.root_pattern(unpack(efm_root_markers)),
    init_options = { documentFormatting = true },
    settings = { rootMarkers = efm_root_markers, languages = efm_languages },
}

return M
