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
}

packer.init(config)

-- plugins
return packer.startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

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
        },
        config = function()
            require('config.treesitter')
        end,
    })

    -- demanded plugins
    use({ 'nvim-lua/plenary.nvim', opt = true })
    use({ 'nvim-lua/popup.nvim', opt = true })

    -- colorscheme
    use({
        'folke/tokyonight.nvim',
        config = function()
            require('config.colorscheme')
        end,
    })

    -- devicons support
    use({
        'kyazdani42/nvim-web-devicons',
        opt = true,
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
        after = 'LuaSnip',
        config = function()
            require('config.cmp')
        end,
        requires = {
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'cmp_luasnip' },
            {
                'tzachar/cmp-tabnine',
                run = './install.sh',
                after = 'cmp-nvim-lsp',
                config = function()
                    local tabnine = require('cmp_tabnine.config')
                    tabnine:setup({
                        max_lines = 1000,
                        max_num_results = 20,
                        sort = true,
                    })
                end,
            },
            { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' },
        },
    })

    -- Snippets
    use({
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        wants = 'friendly-snippets',
        config = function()
            require('config.luasnip')
        end,
    })
    use({ 'rafamadriz/friendly-snippets', opt = true })

    -- Autopairs
    use({
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = function()
            require('config.autopairs')
        end,
    })

    -- DAP
    use({
        'mfussenegger/nvim-dap',
        keys = '<leader>dd',
        cmd = { 'DIInstall', 'DIList' },
        config = function()
            require('config.dap')
        end,
        requires = {
            {
                'Pocco81/DAPInstall.nvim',
                after = 'nvim-dap',
                config = function()
                    require('config.dapinstall')
                end,
            },
        },
    })

    -- Telescope.nvim
    use({
        'nvim-telescope/telescope.nvim',
        keys = { '<C-s>f', '<C-s>p' },
        cmd = 'Telescope',
        wants = {
            'nvim-web-devicons',
            'plenary.nvim',
            'popup.nvim',
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
        },
    })

    -- Markdown
    use({
        'plasticboy/vim-markdown',
        ft = 'markdown',
        wants = { 'tabular' },
        requires = {
            { 'godlygeek/tabular', cmd = { 'Tabularize' } },
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
        requires = {
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
                opt = true,
            },
        },
        config = function()
            require('config.kommentary')
        end,
    })

    -- registers
    use({ 'tversteeg/registers.nvim', keys = { { 'n', '"' }, { 'i', '<c-r>' } } })

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
            'gg',
            'G',
        },
        config = function()
            require('neoscroll').setup()
        end,
    })

    -- A pretty list for showing diagnostics, references,
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
        opt = true,
        event = 'BufRead',
    })

    -- alignment
    use({
        'junegunn/vim-easy-align',
        cmd = 'EasyAlign',
    })

    -- A tree like view for symbols using LSP
    use({
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
    })

    -- Switch between single-line and multiline of code
    use({
        'AndrewRadev/splitjoin.vim',
        keys = { 'gS', 'gJ' },
    })

    -- orgmode
    use({
        'kristijanhusak/orgmode.nvim',
        config = function()
            require('orgmode').setup({
                org_agenda_files = { '~/Dropbox/org/*' },
                org_default_notes_file = '~/Dropbox/org/refile.org',
            })
        end,
    })
end)
