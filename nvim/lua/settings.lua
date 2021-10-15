local opt = vim.opt
local g = vim.g

-- Share clipboard with system
opt.clipboard = 'unnamedplus'
-- Hide buffers instead of closing
opt.hidden = true
-- Hide current mode, like: -- INSERT --
opt.showmode = false
-- Highlight current line
opt.cursorline = true
-- Show commands in status line
opt.showcmd = true
-- Command <Tab> completion, list matches, then longest common part, then all.
opt.wildmenu = true
opt.wildmode = { 'list:longest', 'full' }
opt.wildignore = opt.wildignore
    + { '**/node_modules/**', '**/dist/**', '**/vendor/**' }
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
opt.scrolloff = 5
-- Enable line wrapping
opt.wrap = true
-- Backspace and cursor keys wrap too
opt.whichwrap:append('hl')
-- Tabs are spaces
opt.expandtab = true
-- Use indents of 4 spaces
opt.shiftwidth = 4
-- Indent using four spaces
opt.tabstop = 4
-- Let backspace delete indent
opt.softtabstop = 4
-- Open vsplit to the right
opt.splitright = true
-- Open split to the bottom
opt.splitbelow = true
-- Reduce update time to 250 ms
opt.updatetime = 250
-- Always show the signcolumn
opt.signcolumn = 'auto:1'
-- Turn backup off
opt.swapfile = false
opt.writebackup = false
-- Don't redraw while executing macros
opt.lazyredraw = true
--Enable break indent
opt.breakindent = true
--Save undo history
opt.undofile = true
-- Faster wait time for mapped sequence
opt.timeoutlen = 500
-- More space for command area
-- opt.cmdheight = 2
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
-- make session file save all current window view
opt.sessionoptions:append('options,resize,winpos,terminal')

-- Folding
opt.foldenable = false
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Toggle Hybrid Numbers in insert and normal mode
vim.cmd([[
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end
]])

-- Highlight on yank
vim.cmd([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])

-- Remove numbers from terminal window
vim.cmd([[
augroup terminalView
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END
]])

-- Disable no needed provider
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- Disable unwanted built-in plugins
local disabled_built_ins = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'matchit',
    'matchparen',
    'netrw',
    'netrwFileHandlers',
    'netrwPlugin',
    'netrwSettings',
    'rrhelper',
    'spellfile_plugin',
    'tar',
    'tarPlugin',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end

-- Do not source the default filetype.vim
g.did_load_filetypes = 1

-- use rg for vimgrep
if vim.fn.executable('rg') then
    opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
    opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

-- set global border value
g.border = 'rounded'

-- gutentags
g.gutentags_file_list_command = 'rg --files'
-- vim-matchup
g.matchup_matchparen_offscreen = { method = 'popup' }
-- vim-table-mode
g.table_mode_corner = '|'
