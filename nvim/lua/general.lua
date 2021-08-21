local opt = vim.opt
local g = vim.g

-- True color support
opt.termguicolors = true
opt.background = 'dark'

-- Share clipboard with system
opt.clipboard = opt.clipboard + { 'unnamedplus' }
-- Allow for cursor beyond last character
opt.virtualedit = 'onemore'
-- Increase history limit
opt.history = 1000
-- Hide buffers instead of closing
opt.hidden = true

-- Hide current mode, like: -- INSERT --
opt.showmode = false
-- Highlight current line
opt.cursorline = true
-- Max number of tabs
opt.tabpagemax = 20
-- Show commands in status line
opt.showcmd = true

-- Show list instead of just completing
opt.wildmenu = true
-- Command <Tab> completion, list matches, then longest common part, then all.
opt.wildmode = { 'list:longest', 'full' }
opt.wildignore = opt.wildignore
    + { '**/node_modules/**', '**/dist/**', '**/vendor/**' }
-- Backspace for dummies
opt.backspace = { 'indent', 'eol', 'start' }
-- No extra spaces between rows
opt.linespace = 0
-- Line numbers on
opt.number = true

-- Show matching brackets/parenthesis
opt.showmatch = true
-- Find as you type search
opt.incsearch = true
-- Highlight search terms
opt.hlsearch = true
-- Ignore case when search
opt.ignorecase = true
-- Switch to case sensitive when upper case exist
opt.smartcase = true

-- Lines to scroll when cursor leaves screen
opt.scrolljump = 5
-- Minimum lines to keep above and below cursor
opt.scrolloff = 3
-- Enable line wrapping
opt.wrap = true
-- Backspace and cursor keys wrap too
opt.whichwrap = 'b,s,h,l,<,>,[,]'

-- Inherit the indentation of previous lines
opt.autoindent = true
-- Tabs are spaces
opt.expandtab = true
-- Use indents of 4 spaces
opt.shiftwidth = 4
-- Indent using four spaces
opt.tabstop = 4
-- Let backspace delete indent
opt.softtabstop = 4
-- Use smart tab
opt.smarttab = true

-- Open vsplit to the right
opt.splitright = true
-- Open split to the bottom
opt.splitbelow = true

-- Reduce time to 300 ms
opt.updatetime = 300
-- Always show the signcolumn
opt.signcolumn = 'number'

-- Turn backup off
vim.cmd([[set nobackup]])
vim.cmd([[set noswapfile]])
vim.cmd([[set nowritebackup]])

-- Don't redraw while executing macros
opt.lazyredraw = true
-- Limit the files searched for auto-completes
opt.complete = opt.complete - { 'i' }
-- Always show current position
opt.ruler = true

-- max line width to 80
opt.textwidth = 80
opt.formatoptions = opt.formatoptions + { 't' }
opt.colorcolumn = '+1'

-- For regular expressions
opt.magic = true
-- Detect if a file have been changed outside of Vim
opt.autoread = true
-- Interpret octal as decimal
opt.nrformats = opt.nrformats - { 'octal' }
-- Faster wait time for mapped sequence
opt.timeoutlen = 500
-- show empty chars
vim.wo.list = true
vim.opt.listchars = {
    space = '⋅',
    eol = '↴',
    tab = '│⋅',
    trail = '•',
    extends = '❯',
    precedes = '❮',
    nbsp = '_',
}

-- Folding
vim.cmd([[set nofen]])
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Toggle Hybrid Numbers in insert and normal mode
opt.relativenumber = true
vim.cmd([[
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]])

-- Highlight on yank
vim.cmd([[
augroup highlightYank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{}
 augroup END
]])

-- Disable no needed provider
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- Disable unwanted built-in plugins
local disabled_built_ins = {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'spellfile_plugin',
    'matchit',
    'matchparen',
    'tutor_mode_plugin',
    'remote_plugins',
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end

g.rooter_patterns = {
    '.git',
    'package.json',
    'go.mod',
}

-- use rg for vimgrep
if vim.fn.executable('rg') then
    opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
    opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end
