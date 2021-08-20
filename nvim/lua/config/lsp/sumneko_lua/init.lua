local sumneko_root_path = os.getenv('HOME') .. '/workspace/lua-language-server'
local sumneko_binary = os.getenv('HOME')
    .. '/workspace/lua-language-server/bin/Linux/lua-language-server'

local M = {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    -- settings = {
    --     Lua = {
    --         runtime = {
    --             -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    --             version = 'LuaJIT',
    --             -- Setup your lua path
    --             path = vim.split(package.path, ';'),
    --         },
    --         diagnostics = {
    --             -- Get the language server to recognize the `vim` global
    --             globals = { 'vim' },
    --         },
    --         telemetry = { enable = false },
    --     },
    -- },
}

return M
