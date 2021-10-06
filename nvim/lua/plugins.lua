local fn = vim.fn

-- Download packer if it is not installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

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
local use = packer.use

-- pakcer configs
local config = {
    display = {
        open_fn = function()
            return require('packer.util').float({ border = vim.g.border })
        end,
    },
    git = {
        clone_timeout = 600, -- Timeout, in seconds, for git clones
    },
    profile = {
        enable = true,
        threshold = 0,
    },
}
packer.init(config)

-- plugins
return packer.startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    -- improve performance
    use('lewis6991/impatient.nvim')
    -- demanded plugins
    use('nvim-lua/plenary.nvim')
    -- devicons support
    use('kyazdani42/nvim-web-devicons')

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

    -- colorscheme
    use({
        'EdenEast/nightfox.nvim',
        config = function()
            require('config.colorscheme')
        end,
    })

    -- status line
    use({
        'shadmansaleh/lualine.nvim',
        event = 'BufRead',
        config = function()
            require('config.statusline')
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
            'nvim-lsp-installer',
            'null-ls.nvim',
            'lsp_signature.nvim',
            'vim-illuminate',
        },
        requires = {
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
            {
                'williamboman/nvim-lsp-installer',
                opt = true,
            },
            {
                'RRethy/vim-illuminate',
                opt = true,
            },
        },
    })

    -- completion
    use({
        'hrsh7th/nvim-cmp',
        after = 'LuaSnip',
        config = function()
            require('config.cmp')
        end,
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            -- 'hrsh7th/cmp-path',
        },
    })

    -- Snippets
    use({
        'L3MON4D3/LuaSnip',
        config = function()
            require('config.luasnip')
        end,
        requires = 'rafamadriz/friendly-snippets',
    })

    -- Autopairs
    use({
        'windwp/nvim-autopairs',
        event = 'InsertCharPre',
        config = function()
            require('config.autopairs')
        end,
    })

    -- Tags
    use({
        'ludovicchabant/vim-gutentags',
        event = 'BufRead',
    })

    -- Telescope.nvim
    use({
        'nvim-telescope/telescope.nvim',
        keys = { '<C-s>f', '<C-s>p', '<C-s>F' },
        cmd = 'Telescope',
        config = function()
            require('config.telescope')
        end,
        requires = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                after = 'telescope.nvim',
                config = function()
                    require('telescope').load_extension('fzf')
                end,
                run = 'make',
            },
            {
                'ahmedkhalf/project.nvim',
                after = 'telescope.nvim',
                config = function()
                    require('project_nvim').setup()
                    require('telescope').load_extension('projects')
                end,
            },
            {
                'nvim-telescope/telescope-frecency.nvim',
                after = 'telescope.nvim',
                wants = 'sqlite.lua',
                config = function()
                    require('telescope').load_extension('frecency')
                end,
                requires = { { 'tami5/sqlite.lua', opt = true } },
            },
        },
    })

    -- Markdown
    use({
        'plasticboy/vim-markdown',
        ft = 'markdown',
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
    })

    -- Quoting/parenthesizing made simple
    use({
        'blackCauldron7/surround.nvim',
        event = 'BufRead',
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

    -- registers
    use({
        'tversteeg/registers.nvim',
        keys = { { 'n', '"' }, { 'i', '<C-r>' } },
    })

    -- indention support
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
        keys = { '<leader>jw', '<leader>jl' },
        config = function()
            require('config.hop')
        end,
    })

    -- A snazzy bufferline for Neovim
    use({
        'akinsho/bufferline.nvim',
        event = 'BufRead',
        config = function()
            require('config.bufferline')
        end,
    })

    -- better %, navigate and highlight matching words
    use({
        'andymass/vim-matchup',
        event = 'BufRead',
        config = function()
            require('config.matchup')
        end,
    })

    -- A tree like view for symbols using LSP
    use({
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
    })

    -- alignment
    use({ 'junegunn/vim-easy-align', cmd = 'EasyAlign' })

    -- Switch between single-line and multiline of code
    use({
        'AndrewRadev/splitjoin.vim',
        keys = { 'gS', 'gJ' },
    })
end)
