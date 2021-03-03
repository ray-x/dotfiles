local lang = {}
local conf = require('modules.lang.config')


lang['nvim-treesitter/nvim-treesitter'] = {
  config = conf.nvim_treesitter,
}

lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
  after = 'nvim-treesitter'
}

lang['w0rp/ale'] = {
  event = 'BufWritePre',
  cmd = 'ALEEnable',
  after = 'telescope.nvim',
  config = conf.ale,--'vim.cmd[[ALEEnable]]',
}


lang['shmup/vim-sql-syntax'] = {
  ft = {'sql', 'pgsql'}
}

lang['nanotee/sqls.nvim'] = {
  ft = {'sql', 'pgsql'},
  config = conf.sqls
}

lang['fatih/vim-go'] = {
 ft = 'go',
 event = 'InsertEnter',
 cmd = {'GoImport', 'GoImports', 'GoTest', 'GoBuild'}, run = ':GoInstallBinaries',
 config = conf.go
}

lang['mtdl9/vim-log-highlighting'] = { ft={'text', 'log'}}

return lang
