local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git',
        'clone',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    vim.cmd('packadd packer.nvim')
end

local packer = require('packer')
vim.cmd([[packadd packer.nvim]])

local use = packer.use

local config = {
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
    },
    git = {
        clone_timeout = 600, -- Timeout, in seconds, for git clones
    },
    profile = {
        enable = true,
        threshold = 0,
    },
    disable_commands = false,
}

packer.init(config)

return packer.startup(function()
    -- Packer can manage itself
    use({ 'wbthomason/packer.nvim', opt = true })

    -- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        run = ':TSUpdate',
        requires = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                branch = '0.5-compat',
            },
            'RRethy/nvim-treesitter-textsubjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function()
            require('config.treesitter')
        end,
    })

    use({ 'nvim-lua/popup.nvim', opt = true })
    use({ 'nvim-lua/plenary.nvim', opt = true })

    -- Prisma syntax highlighting
    use({ 'pantharshit00/vim-prisma', ft = 'prisma' })

    -- colorscheme
    use({
        'lifepillar/vim-gruvbox8',
        config = function()
            require('config.colorscheme')
        end,
    })

    use({
        'kyazdani42/nvim-web-devicons',
        opt = true,
        config = function()
            require('nvim-web-devicons').setup({ default = true })
        end,
    })

    -- Lualine
    use({
        'hoob3rt/lualine.nvim',
        event = 'BufRead',
        wants = { 'nvim-web-devicons' },
        config = function()
            require('config.lualine')
        end,
    })

    -- LSP
    use({
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        config = function()
            require('config.lsp')
        end,
        wants = {
            'plenary.nvim',
            'lua-dev.nvim',
            'null-ls.nvim',
            'lsp_signature.nvim',
        },
        requires = {
            { 'folke/lua-dev.nvim', opt = true },
            { 'jose-elias-alvarez/null-ls.nvim', opt = true },
            {
                'jose-elias-alvarez/nvim-lsp-ts-utils',
                ft = {
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                    'vue',
                },
            },
            { 'ray-x/lsp_signature.nvim', opt = true },
        },
    })

    use({
        'hrsh7th/nvim-compe',
        event = 'InsertEnter',
        config = function()
            require('config.compe')
        end,
        wants = { 'LuaSnip', 'nvim-autopairs' },
        requires = {
            {
                'L3MON4D3/LuaSnip',
                opt = true,
                wants = 'friendly-snippets',
                config = function()
                    require('config.luasnip')
                end,
            },
            { 'rafamadriz/friendly-snippets', opt = true },
            {
                'windwp/nvim-autopairs',
                opt = true,
                config = function()
                    require('config.autopairs')
                end,
            },
        },
    })

    -- Telescope.nvim
    use({
        'nvim-telescope/telescope.nvim',
        keys = { '<c-p>', '<leader>g', '<leader>rg' },
        cmd = 'Telescope',
        wants = {
            'nvim-web-devicons',
            'plenary.nvim',
            'popup.nvim',
        },
        config = function()
            require('config.telescope')
        end,
        requires = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                config = function()
                    require('telescope').load_extension('fzf')
                end,
                after = 'telescope.nvim',
                run = 'make',
            },
        },
    })

    -- Changes Vim working directory to project root
    use('airblade/vim-rooter')

    -- Markdown
    use({
        'plasticboy/vim-markdown',
        ft = 'markdown',
        wants = { 'tabular' },
        requires = {
            { 'godlygeek/tabular', cmd = { 'Tabular' } },
        },
        setup = function()
            require('config.markdown')
        end,
    })

    use({
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = function()
            fn['mkdp#util#install']()
        end,
        cmd = { 'MarkdownPreviewToggle' },
    })

    -- Emmet support
    use({
        'mattn/emmet-vim',
        ft = {
            'css',
            'scss',
            'less',
            'html',
            'vue',
            'javascriptreact',
            'typescriptreact',
            'markdown',
        },
    })
    -- Quoting/parenthesizing made simple
    use({
        'blackCauldron7/surround.nvim',
        keys = 'BufRead',
        config = function()
            require('surround').setup({})
        end,
    })
    -- Comment stuff out
    use({
        'b3nj5m1n/kommentary',
        keys = { 'gc', 'gcc' },
        wants = { 'nvim-ts-context-commentstring' },
        config = function()
            require('config.kommentary')
        end,
    })
    -- Enable repeating supported plugin maps with '.'
    use({ 'tpope/vim-repeat', keys = { { 'n', '.' } } })
    -- Manage registers
    use({ 'tversteeg/registers.nvim', keys = { { 'n', '"' }, { 'i', '<c-r>' } } })

    -- indention
    use({
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            require('config.blankline')
        end,
    })

    -- Motions
    use({
        'phaazon/hop.nvim',
        event = 'BufRead',
        config = function()
            require('config.hop')
        end,
    })

    -- A snazzy bufferline for Neovim
    use({
        'akinsho/nvim-bufferline.lua',
        event = 'BufRead',
        config = function()
            require('config.bufferline')
        end,
        wants = 'nvim-web-devicons',
    })

    use({
        'christoomey/vim-tmux-navigator',
        cmd = {
            'TmuxNavigateLeft',
            'TmuxNavigateRight',
            'TmuxNavigateRight',
            'TmuxNavigateLeft',
            'TmuxNavigatePrevious',
        },
    })

    use({
        'karb94/neoscroll.nvim',
        keys = {
            '<C-u>',
            '<C-d>',
            'gg',
            'G',
        },
        config = function()
            require('neoscroll').setup()
        end,
    })

    use({
        'folke/trouble.nvim',
        event = 'BufRead',
        wants = 'nvim-web-devicons',
        config = function()
            require('config.trouble')
        end,
    })
end)
