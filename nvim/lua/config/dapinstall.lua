local dap_install = require('dap-install')
local dbg_list = require('dap-install.debuggers_list').debuggers

dap_install.setup({
    installation_path = vim.fn.stdpath('data') .. '/dapinstall/',
    verbosely_call_debuggers = false,
})

local debuggers = {
    go_delve_dbg = {
        adapters = function(callback, config)
            local stdout = vim.loop.new_pipe(false)
            local handle
            local pid_or_err
            local port = 38697
            local opts = {
                stdio = { nil, stdout },
                args = { 'dap', '-l', '127.0.0.1:' .. port },
                detached = true,
            }
            handle, pid_or_err = vim.loop.spawn('dlv', opts, function(code)
                stdout:close()
                handle:close()
                if code ~= 0 then
                    print('dlv exited with code', code)
                end
            end)
            assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
            stdout:read_start(function(err, chunk)
                assert(not err, err)
                if chunk then
                    vim.schedule(function()
                        require('dap.repl').append(chunk)
                    end)
                end
            end)
            -- Wait for delve to start
            vim.defer_fn(function()
                callback({ type = 'server', host = '127.0.0.1', port = port })
            end, 100)
        end,
        configurations = {
            {
                type = 'go',
                name = 'Debug',
                request = 'launch',
                program = '${workspaceFolder}/${file}',
            },
            {
                type = 'go',
                name = 'Debug test', -- configuration for debugging test files
                request = 'launch',
                mode = 'test',
                program = '${workspaceFolder}/${file}',
            },
            -- works with go.mod packages and sub packages
            {
                type = 'go',
                name = 'Debug test (go.mod)',
                request = 'launch',
                mode = 'test',
                program = './${relativeFileDirname}',
            },
        },
    },
    jsnode_dbg = {
        adapters = {
            type = 'executable',
            command = 'node',
            args = {
                vim.fn.stdpath('data')
                    .. '/dapinstall/jsnode_dbg/vscode-node-debug2/out/src/nodeDebug.js',
            },
        },
        configurations = {
            {
                type = 'node2',
                request = 'launch',
                program = '${workspaceFolder}/${file}',
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = 'inspector',
                console = 'integratedTerminal',
            },
        },
    },
}

for debugger, _ in pairs(dbg_list) do
    dap_install.config(debugger, debuggers[debugger])
end