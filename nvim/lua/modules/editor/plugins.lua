local editor = {}
local conf = require('modules.editor.config')

-- editor['Raimondi/delimitMate'] = {
--   event = 'InsertEnter',
--   config = conf.delimimate,
-- }

-- alternatives: steelsojka/pears.nvim
-- windwp/nvim-ts-autotag  'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue'
-- windwp/nvim-autopairs

editor['windwp/nvim-autopairs'] = {
  event = 'InsertEnter',
  config = conf.autopairs,
  opt = true
}

editor['rhysd/accelerated-jk'] = {
  opt=true
}
editor['tpope/vim-surround'] ={
  opt=true,
  event = 'InsertEnter',
  --keys={'c', 'd'}
}

editor['steelsojka/pears.nvim'] = {
  -- keys = {{'(','[', '<', '{'}},
  -- event = 'InsertEnter',
  config =  conf.pears_setup(),
  opt=true
}
-- editor['/Users/ray.xu/github/pears.nvim'] = {
--   -- keys = {{'(','[', '<', '{'}},
--   -- event = 'InsertEnter',
--   config =  conf.pears_setup(),
--   -- opt=true
-- }

-- nvim-colorizer replacement
editor['rrethy/vim-hexokinase'] = {
  -- ft = { 'html','css','sass','vim','typescript','typescriptreact'},
  config = conf.hexokinase,
  run = 'make hexokinase',
  opt = true,
  cmd = {'HexokinaseTurnOn', 'HexokinaseToggle'}
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

editor['kevinhwang91/nvim-hlslens'] = {
  keys = {'/', '?', 'n', 'N', '*', '#', 'g'},
  opt = true,
  config = conf.hlslens
}

editor['mg979/vim-visual-multi']  = {
  keys = {'<C-n>','<M-n>','<S-Down>','<S-Up>','<M-Left>','<M-Right>','<M-D>','<M-Down>', '<C-d>', '<C-Down>', '<S-Right>', '<C-LeftMouse>', '<M-C-RightMouse>','<Leader>'},
  opt = true,
  setup = conf.vmulti,
}

editor['phaazon/hop.nvim']  = {
  as = 'hop',
  keys = {'e', '?', 'n', '$'},
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end
}

editor['preservim/nerdcommenter'] = {
  cmd = {'NERDCommenterComment', 'NERDCommenterToggle'},
  keys = {'<Leader>c<space>', '\\c ', '<Leader>cc', '//', '<M-/>'},
  setup = conf.nerdcommenter,
  opt = true,
}
-- copy paste failed in block mode when clipboard = unnameplus"
editor['bfredl/nvim-miniyank']  = {
  keys = {'p','y', '<C-v>'},
  opt = true,
  setup = function ()
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
editor['chaoren/vim-wordmotion'] = {opt = true, keys = {'w','W', 'gE', 'aW'}}
-- chaoren/vim-wordmotion
return editor
