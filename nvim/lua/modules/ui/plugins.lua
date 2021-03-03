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
  config = function()
    require('indent_guides').setup({
      -- put your options in here
      indent_guide_size = 1;
      indent_start_level = 2;
      indent_tab_guides = true;
      indent_pretty_mode = true;
      even_colors = { fg ='#3a3834', bg='#232b36' };
      odd_colors  = { fg ='#471b56', bg='#1f1b24'};
    })
  end
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
  requires = {'kyazdani42/nvim-web-devicons'},
  config = conf.nvim_tree,
}

-- ui['mhinz/vim-signify'] = {
--   event = {'BufReadPre','BufNewFile'},
--   config = conf.vim_signify
-- }

-- not compatiable with treesitter, need to disable treesiter hl-match
-- ui['luochen1990/rainbow'] = {
-- 	opt=false, 
-- 	event = {'BufReadPre','BufNewFile'},
-- 	config=function () vim.g.rainbow_active = 1 end
-- }
-- ui['Yggdroot/indentLine'] = {config=conf.identline}
ui['ray-x/vim-interestingwords'] = { keys =  {'<Leader>u'}, config = conf.interestingwords, opt = true}
ui['ray-x/aurora'] = {config = conf.theme}

ui['Xuyuanp/scrollbar.nvim'] = {config=conf.scrollbar}

return ui
