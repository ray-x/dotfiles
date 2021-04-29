local ui = {}
local conf = require('modules.ui.config')

-- ui['glepnir/zephyr-nvim'] = {
--   config = [[vim.cmd('colorscheme zephyr')]]
-- }
--
local winwidth = function ()
  return vim.api.nvim_call_function('winwidth', {0})
end

ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf.galaxyline,
  requires = {'kyazdani42/nvim-web-devicons'}
}

ui['Akin909/nvim-bufferline.lua'] = {
  config = conf.nvim_bufferline,
  requires = {'kyazdani42/nvim-web-devicons'}
}
-- 'luaromgrk/barbar.nvim'
-- ui['romgrk/barbar.nvim'] = {
--   config = conf.barbar,
--   requires = {'kyazdani42/nvim-web-devicons'}
-- }
--

ui['wfxr/minimap.vim'] = {
  run = ':!cargo install --locked code-minimap',
  keys = {'<F14>'},
  cmd = {'Minimap', 'MinimapToggle'},
  config = conf.minimap
}
-- ui['glepnir/dashboard-nvim'] = {
--   config = conf.dashboard
-- }

ui['kyazdani42/nvim-tree.lua'] = {
  cmd = {'NvimTreeToggle','NvimTreeOpen'},
  keys = {'<F1>', '<F13>'},
  requires = {'kyazdani42/nvim-web-devicons'},
  config = conf.nvim_tree,
}


ui['lukas-reineke/indent-blankline.nvim'] = {config=conf.blankline, branch = 'lua', opt = true}

ui['ray-x/vim-interestingwords'] = { keys =  {'<Leader>u'}, config = conf.interestingwords, opt = true}

ui['ray-x/aurora'] = {config = conf.theme}

ui['dstein64/nvim-scrollview'] = {config = conf.scrollview}
return ui
