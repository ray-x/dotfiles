local editor = {}
local conf = require('modules.editor.config')

editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf.delimimate,
}

editor['rhysd/accelerated-jk'] = {
  opt = true
}

editor['norcalli/nvim-colorizer.lua'] = {
  -- ft = { 'html','css','sass','vim','typescript','typescriptreact'},
  config = conf.nvim_colorizer
}

editor['Raimondi/delimitMate'] = {
  event = {'InsertEnter'},
}

editor['hrsh7th/vim-eft'] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end
}

-- editor['kana/vim-operator-replace'] = {
--   keys = {{'x','p'}},
--   config = function()
--     vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
--   end,
--   requires = 'kana/vim-operator-user'
-- }

-- editor['rhysd/vim-operator-surround'] = {
--   event = 'BufRead',
--   requires = 'kana/vim-operator-user'
-- }

editor['kana/vim-niceblock']  = {
  opt = true
}

editor['kana/vim-smartchr'] = {
  ft = 'go',
  config = conf.vim_smartchar
}

editor['preservim/nerdcommenter'] = {
  cmd = {'NERDCommenterComment', 'NERDCommenterToggle'},
  keys = {'<Leader>c<space>', '\\', '/', '<M-/>'},
  config = conf.nerdcommenter,
}
-- copy paste failed in block mode when clipboard = unnameplus"
editor['bfredl/nvim-miniyank']  = {
  config = function ()
  vim.api.nvim_command('map p <Plug>(miniyank-autoput)')
  vim.api.nvim_command('map P <Plug>(miniyank-autoPut)')

  end
}

editor['simnalamburt/vim-mundo']  = { cmd ={'MundoToggle', 'GundoToggle', 'GundoShow'}}
editor['mbbill/undotree']  = {opt = true}
editor['AndrewRadev/splitjoin.vim']  = {cmd={'SplitjoinJoin','SplitjoinSplit'}}
editor['justinmk/vim-sneak']  = {keys = {'s'}} 
editor['chaoren/vim-wordmotion']  = {keys = {'ci', 'ciw','w','W'}} 
-- chaoren/vim-wordmotion
return editor
