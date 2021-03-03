local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
  event = 'BufRead',
  config = conf.nvim_lsp,
}

completion['glepnir/lspsaga.nvim'] = {
  cmd = 'Lspsaga',
}

completion['hrsh7th/nvim-compe'] = {
  event = 'InsertEnter',
  config = conf.nvim_compe,
}

completion['hrsh7th/vim-vsnip'] = {
  event = 'InsertCharPre',
  config = conf.vim_vsnip
}

completion['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    {'nvim-lua/popup.nvim', opt = true},
    {'nvim-lua/plenary.nvim',opt = true},
    {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
  },
  opt=true,
}

completion['mattn/vim-sonictemplate'] = {
  cmd = 'Template',
  ft = {'go','typescript','lua','javascript','vim','rust','markdown'},
  config = conf.vim_sonictemplate,
}

completion['mattn/emmet-vim'] = {
  event = 'InsertEnter',
  ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
  config = conf.emmet,
}

completion['RRethy/vim-illuminate'] = {
  event = 'InsertEnter',
  config = function()
    vim.g.Illuminate_delay = 200
    vim.g.Illuminate_ftblacklist = {'nerdtree', 'nvimtree', 'vista'}
  end
}
completion['tzachar/compe-tabnine'] = {
  event = 'InsertEnter',
  run = './install.sh', 
  opt=true,
}
completion['nvim-lua/lsp-status.nvim'] = {
  opt=false,
}

completion['ray-x/lsp_signature.nvim'] = {
  config = function() require "lsp_signature".on_attach() end
}

return completion
