local editor = {}
local conf = require('modules.editor.config')

editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf.delimimate,
}

editor['rhysd/accelerated-jk'] = {
  opt = true
}

-- editor['norcalli/nvim-colorizer.lua'] = {
--   -- ft = { 'html','css','sass','vim','typescript','typescriptreact'},
--   config = conf.nvim_colorizer
-- }
-- nvim-colorizer replacement
editor['rrethy/vim-hexokinase'] = {
  -- ft = { 'html','css','sass','vim','typescript','typescriptreact'},
  config = conf.hexokinase,
  run = 'make hexokinase',
}

-- editor['hrsh7th/vim-eft'] = {
--   opt = true,
--   config = function()
--     vim.g.eft_ignorecase = true
--   end
-- }

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

-- editor['kana/vim-niceblock']  = {
--   opt = true
-- }

-- editor['kana/vim-smartchr'] = {
--   ft = 'go',
--   config = conf.vim_smartchar
-- }

editor['mg979/vim-visual-multi']  = {
  keys = {'<C-n>','<M-n>','<S-Down>','<S-Up>','<M-Left>','<M-Right>','<M-D>','<M-Down>', '<C-d>', '<C-Down>', '<S-Right>', '<C-LeftMouse>', '<M-C-RightMouse>','<Leader>'},
  opt = true,
  config = conf.vmulti,
}

editor['phaazon/hop.nvim']  = {
  as = 'hop',
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end
}

editor['preservim/nerdcommenter'] = {
  cmd = {'NERDCommenterComment', 'NERDCommenterToggle'},
  keys = {'<Leader>c<space>', '\\c ', '<Leader>cc', '//', '<M-/>'},
  config = conf.nerdcommenter,
  opt = true,
}
-- copy paste failed in block mode when clipboard = unnameplus"
editor['bfredl/nvim-miniyank']  = {
  keys = {'p','y', '<C-v>'},
  opt = true,
  config = function ()
    vim.api.nvim_command('map p <Plug>(miniyank-autoput)')
    vim.api.nvim_command('map P <Plug>(miniyank-autoPut)')
  end
}

-- fix terminal color
editor['norcalli/nvim-terminal.lua']  = { opt = true, ft={'log', 'terminal'}, config=function ()
  require'terminal'.setup()
end}

editor['simnalamburt/vim-mundo']  = { opt = true, cmd ={'MundoToggle', 'GundoToggle', 'GundoShow'}}
editor['mbbill/undotree']  = {opt = true}
editor['AndrewRadev/splitjoin.vim']  = {opt = true, cmd={'SplitjoinJoin','SplitjoinSplit'}, keys = {'gS', 'gJ'}}
editor['justinmk/vim-sneak']  = {opt = true, keys = {'s'}, config = function() vim.g['sneak#label']= 1 end}
editor['chaoren/vim-wordmotion'] = {} -- = {opt = true, keys = {'c', 'ci', 'ciw', 'w','W'}}
-- chaoren/vim-wordmotion
return editor
