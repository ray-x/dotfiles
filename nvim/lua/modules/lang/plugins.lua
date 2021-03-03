local lang = {}
local conf = require('modules.lang.config')


lang['nvim-treesitter/nvim-treesitter'] = {
  config = conf.nvim_treesitter,
}

lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
  after = 'nvim-treesitter',
  opt = false,
}

lang['w0rp/ale'] = {
  event = 'BufWritePre',
  cmd = 'ALEEnable',
  -- after = 'telescope.nvim',
  config = conf.ale,--'vim.cmd[[ALEEnable]]',
  opt=true,
}


lang['shmup/vim-sql-syntax'] = {
  ft = {'sql', 'pgsql'}
}

lang['nanotee/sqls.nvim'] = {
  ft = {'sql', 'pgsql'},
  config = conf.sqls,
  opt=true,
}

lang['fatih/vim-go'] = {
 -- ft = 'go',
 event = 'InsertEnter',
 cmd = {'GoImport', 'GoImports', 'GoTest', 'GoBuild', 'GoFmt', 'G'}, 
 run = ':GoInstallBinaries',
 config = conf.go,
 opt=true,
}

lang['mtdl9/vim-log-highlighting'] = { ft={'text', 'log'}}

return lang
