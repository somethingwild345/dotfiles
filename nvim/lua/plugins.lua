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
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/lua/config/packer_compiled.lua',
}
packer.init(config)

-- plugins
return packer.startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    use('lewis6991/impatient.nvim')

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
            'JoosepAlviste/nvim-ts-context-commentstring',
            'windwp/nvim-ts-autotag',
        },
        config = function()
            require('config.treesitter')
        end,
    })

    -- demanded plugins
    use({ 'nvim-lua/plenary.nvim', opt = true })

    -- colorscheme
    use({
        'Pocco81/Catppuccino.nvim',
        config = function()
            require('config.colorscheme')
        end,
    })

    -- devicons support
    use({
        'kyazdani42/nvim-web-devicons',
        opt = true,
    })

    -- status line
    use({
        'shadmansaleh/lualine.nvim',
        wants = 'nvim-web-devicons',
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
            'plenary.nvim',
            'nvim-lsp-installer',
            'null-ls.nvim',
            'lsp_signature.nvim',
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
        },
    })

    -- completion
    use({
        'hrsh7th/nvim-cmp',
        after = 'friendly-snippets',
        config = function()
            require('config.cmp')
        end,
        requires = {
            { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'cmp_luasnip' },
            { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' },
            { 'hrsh7th/cmp-path', after = 'cmp-buffer' },
            { 'quangnguyen30192/cmp-nvim-tags', after = 'cmp-buffer' },
        },
    })

    -- Snippets
    use({
        'L3MON4D3/LuaSnip',
        wants = 'friendly-snippets',
        after = 'nvim-cmp',
        config = function()
            require('config.luasnip')
        end,
    })
    use({ 'rafamadriz/friendly-snippets', event = 'InsertEnter' })

    -- Autopairs
    use({
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = function()
            require('config.autopairs')
        end,
    })

    -- Tags
    use({
        'ludovicchabant/vim-gutentags',
        event = 'BufRead',
    })

    -- Git
    use({
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        wants = 'plenary.nvim',
        config = function()
            require('config.gitsigns')
        end,
    })

    -- Telescope.nvim
    use({
        'nvim-telescope/telescope.nvim',
        keys = { '<C-s>f', '<C-s>p', '<C-s>F' },
        cmd = 'Telescope',
        wants = {
            'nvim-web-devicons',
            'plenary.nvim',
            'trouble.nvim',
        },
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
        keys = { { 'n', '"' }, { 'i', '<c-r>' } },
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
        event = 'BufRead',
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
        wants = 'nvim-web-devicons',
    })

    -- smooth scrolling
    use({
        'karb94/neoscroll.nvim',
        keys = {
            '<C-u>',
            '<C-d>',
        },
        config = function()
            require('neoscroll').setup()
        end,
    })

    -- A pretty list for showing diagnostics, references
    use({
        'folke/trouble.nvim',
        opt = true,
        wants = 'nvim-web-devicons',
        config = function()
            require('config.trouble')
        end,
    })

    -- better %, navigate and highlight matching words
    use({
        'andymass/vim-matchup',
        config = function()
            require('config.matchup')
        end,
        event = 'BufRead',
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

    -- File explorer
    use({
        'mcchrish/nnn.vim',
        cmd = 'NnnPicker',
        config = function()
            require('config.nnn')
        end,
    })
end)
