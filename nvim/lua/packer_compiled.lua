-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/muhammad/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/muhammad/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/muhammad/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/muhammad/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/muhammad/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    after = { "nvim-cmp" },
    loaded = true,
    only_config = true
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\0021\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\22config.bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\2/\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\20config.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\2*\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\15config.hop\frequire\0" },
    keys = { { "", "<leader>jw" }, { "", "<leader>jl" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\0020\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\21config.blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  kommentary = {
    config = { "\27LJ\2\0021\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\22config.kommentary\frequire\0" },
    keys = { { "", "gc" }, { "", "gcc" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/kommentary",
    wants = { "nvim-ts-context-commentstring" }
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\0021\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\22config.statusline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\0020\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\21config.autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\2*\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\15config.cmp\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\2*\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\15config.lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    wants = { "nvim-lsp-installer", "null-ls.nvim" }
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\0021\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0" },
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\2\2.\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\19config.orgmode\frequire\0" },
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\2t\0\0\2\0\6\0\f6\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\3\0B\0\2\0029\0\4\0'\1\5\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\nsetup\17project_nvim\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/project.nvim"
  },
  ["registers.nvim"] = {
    keys = { { "n", '"' }, { "i", "<C-r>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/registers.nvim"
  },
  ["splitjoin.vim"] = {
    keys = { { "", "gS" }, { "", "gJ" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/splitjoin.vim"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\2:\0\0\2\0\3\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0004\1\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/surround.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\2H\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    after = { "project.nvim", "telescope-fzf-native.nvim" },
    commands = { "Telescope" },
    config = { "\27LJ\2\0020\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\21config.telescope\frequire\0" },
    keys = { { "", "<C-s>f" }, { "", "<C-s>p" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["vim-gutentags"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/vim-gutentags"
  },
  ["vim-matchup"] = {
    after_files = { "/home/muhammad/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  },
  ["zenbones.nvim"] = {
    config = { "\27LJ\2\0022\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\23config.colorscheme\frequire\0" },
    loaded = true,
    path = "/home/muhammad/.local/share/nvim/site/pack/packer/start/zenbones.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: orgmode.nvim
time([[Config for orgmode.nvim]], true)
try_loadstring("\27LJ\2\2.\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\19config.orgmode\frequire\0", "config", "orgmode.nvim")
time([[Config for orgmode.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\2.\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\19config.luasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\0021\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\22config.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: zenbones.nvim
time([[Config for zenbones.nvim]], true)
try_loadstring("\27LJ\2\0022\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\23config.colorscheme\frequire\0", "config", "zenbones.nvim")
time([[Config for zenbones.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-cmp ]]

-- Config for: nvim-cmp
try_loadstring("\27LJ\2\2*\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\15config.cmp\frequire\0", "config", "nvim-cmp")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> gcc <cmd>lua require("packer.load")({'kommentary'}, { keys = "gcc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>jw <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "<lt>leader>jw", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gS <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> " <cmd>lua require("packer.load")({'registers.nvim'}, { keys = "\"", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'kommentary'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[inoremap <silent> <C-r> <cmd>lua require("packer.load")({'registers.nvim'}, { keys = "<lt>C-r>" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>jl <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "<lt>leader>jl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-s>p <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-s>p", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-s>f <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-s>f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gJ <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gJ", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'bufferline.nvim', 'gitsigns.nvim', 'lualine.nvim', 'indent-blankline.nvim', 'surround.nvim', 'vim-gutentags', 'vim-matchup'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertCharPre * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertCharPre *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-lspconfig'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles(0) end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
