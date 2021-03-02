local ui = {}
local conf = require('modules.ui.config')

-- ui['glepnir/zephyr-nvim'] = {
--   config = [[vim.cmd('colorscheme zephyr')]]
-- }

ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf.galaxyline,
  requires = {'kyazdani42/nvim-web-devicons'}
}

ui['glepnir/indent-guides.nvim'] = {
  event = 'BufReadPre',
}

ui['Akin909/nvim-bufferline.lua'] = {
  config = conf.nvim_bufferline,
  requires = {'kyazdani42/nvim-web-devicons'}
}

-- ui['glepnir/dashboard-nvim'] = {
--   config = conf.dashboard
-- }

ui['kyazdani42/nvim-tree.lua'] = {
  cmd = {'NvimTreeToggle','NvimTreeOpen'},
  config = conf.nvim_tree,
  requires = {'kyazdani42/nvim-web-devicons'}
}

-- ui['mhinz/vim-signify'] = {
--   event = {'BufReadPre','BufNewFile'},
--   config = conf.vim_signify
-- }


ui['luochen1990/rainbow'] = {opt=true}
ui['Yggdroot/indentLine'] = {config=conf.identline}
ui['ray-x/vim-interestingwords'] = { keys =  {'<Leader>u'}, config = conf.interestingwords}
ui['ray-x/aurora'] = {config = conf.theme}

ui['Xuyuanp/scrollbar.nvim'] = {config=conf.scrollbar}

return ui
