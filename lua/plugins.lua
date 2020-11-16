
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

--- lua require('plugins')
--- command! PackerInstall packadd packer.nvim | lua require('plugins').install()
--- command! PackerUpdate packadd packer.nvim | lua require('plugins').update()
--- command! PackerSync packadd packer.nvim | lua require('plugins').sync()
--- command! PackerClean packadd packer.nvim | lua require('plugins').clean()
--- command! PackerCompile packadd packer.nvim | lua require('plugins').compile()



-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}


  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter *'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
   use {
     'w0rp/ale',
     -- ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake',  'go', 'lua', 'ts', 'js', 'html', 'markdown', 'racket', 'vim', 'tex'},
     cmd = 'ALEEnable',
     event = 'BufWritePre',
     config = 'vim.cmd[[ALEEnable]]'
   }
 
   -- Plugins can have dependencies on other plugins

  --use {'neovim/nvim-lspconfig'}
  --use { 'haorenW1025/completion-nvim'}  
--
  --use {'hrsh7th/vim-vsnip',   opt = true}
  --use {'hrsh7th/vim-vsnip-integ',   opt = true}
  --use {'aca/completion-tabnine', run = './install.sh',   opt = true}
  --use {'steelsojka/completion-buffers',   opt = true}
--
  --use {'haorenW1025/diagnostic-nvim'}
  --use {'nvim-treesitter/completion-treesitter', opt = true}
  --use {'nvim-treesitter/nvim-treesitter', config = 'require("treesitter")'}
 
use {
    'neovim/nvim-lspconfig',
    {
      {'haorenW1025/completion-nvim', event = 'InsertEnter *', config = function()
        local completion = require('completion')
        completion.addCompletionSource('vimtex', require('vimtex').complete_item)
        completion.addCompletionSource('wiki', require('wiki').complete_item)

        vim.cmd [[ augroup lsp_aucmds ]]
        vim.cmd [[ au BufEnter * lua require('completion').on_attach() ]]
        vim.cmd [[ augroup END ]]

        completion.on_attach()
        vim.cmd [[ doautoall FileType ]]
      end,
      requires = {
        {'hrsh7th/vim-vsnip', event = 'InsertEnter *'},
        {'hrsh7th/vim-vsnip-integ', event = 'InsertEnter *'},
        {'https://gitlab.com/HiPhish/completion-nvim-vlime', after = {'completion-nvim', 'vlime'}},
      }
    },
 --    'haorenW1025/diagnostic-nvim',
    {'nvim-treesitter/completion-treesitter', opt = true},
    {'steelsojka/completion-buffers',   opt = true},
    {'aca/completion-tabnine', run = './install.sh',   opt = true},
    {'nvim-treesitter/nvim-treesitter', config = 'require('treesitter')'}
  }
}
   
   use {'ncm2/float-preview.nvim', event = {'InsertEnter'}}
     --{'depends': {'treesitter', 'completion'}, 

   use {'shmup/vim-sql-syntax', ft = {'sql', 'pgsql'}}
   use {'liuchengxu/vista.vim', cmd = {'Vista'}}
   use {'kamykn/spelunker.vim', cmd = 'Spell'}
   use {'skywind3000/asynctasks.vim', cmd = {'AsyncRun', 'AsyncTask'}}
   use {'skywind3000/asyncrun.vim', cmd = {'AsyncRun', 'AsyncTask'}}
   use {'mattn/emmet-vim', ft = {'html','css', 'js', 'ts', 'tsx'} }
   use {'Raimondi/delimitMate', event = 'InsertEnter'}
   use {'preservim/nerdcommenter', 
     cmd = {'NERDCommenterComment', 'NERDCommenterToggle'}, 
     keys = '<Leader>c<space>' }
   -- add comments to code, tomtom/tcomment_vim is another alternative
   use {'mhinz/vim-startify'}
 
 
   use {'euclio/vim-markdown-composer', 
       run = 'cargo build --release', 
       cmd = {'ComposerStart', 'ComposerOpen'}}
   use {'plasticboy/vim-markdown', ft = 'markdown'}
 
   use {'godlygeek/tabular'}
 
   use {'fatih/vim-go', 
     ft = 'go',
     event = 'InsertEnter', 
     cmd = {'GoImport', 'GoImports', 'GoTest', 'GoBuild'}, run = ':GoInstallBinaries' }
 
   use {'buoto/gotests-vim', ft = 'go' } 
 
   use {'voldikss/vim-floaterm', cmd = {'FloatermNew','FloatermToggle'} }
 
   use {'mhinz/vim-signify', cmd = {'SignifyEnable', 'SignifyEnableAll', 'SignifyToggle'} }
 
   use {'vim-test/vim-test', cmd = {'TestNearest', 'TestFile', 'TestSuite'} }
 
   use {'chaoren/vim-wordmotion', keys = {'ciw','w','W'}} -- cond = '<Plug>WordMotion_' 
 
   use {'liuchengxu/vim-clap',  --run = 'clap#installer#force_download()', 
    run = function()
        vim.fn['clap#installer#force_download()'](0)
    end,
   cmd = {'Clap'} } 
   use {'simnalamburt/vim-mundo', cmd ={'MundoToggle', 'GundoToggle', 'GundoShow'}}
   use {'luochen1990/rainbow'}
   use {'Yggdroot/indentLine'}
   use {'mtdl9/vim-log-highlighting', ft={'text', 'log'}}
   use {'ray-x/vim-interestingwords', keys =  {'<Leader>u'}}
   use {'justinmk/vim-sneak', keys = {'s'}} --, cond =  '<Plug>Sneak_'
   use {'ray-x/paleaurora'}
 
 
 
   -- use {'hrsh7th/vim-vsnip', {'on_event': 'InsertEnter'}
   -- use {'hrsh7th/vim-vsnip-integ', {'on_event': 'InsertEnter'}
   -- """""""""""""Nvim specific""""""""""""""
   use {'kevinhwang91/rnvimr', cmd ='RnvimrToggle'}
   use {'rhysd/git-messenger.vim', 
       cmd = 'GitMessenger'}
   --" use {'tveskag/nvim-blame-line' , cmd = {'EnableBlameLine', 'ToggleBlameLine', 'SingleBlameLine'}}
 
   --"""""""""""""LUA Plugins""""""""""""""
   -- use {'kyazdani42/nvim-web-devicons',{as = 'devicons'}
   use {'kyazdani42/nvim-tree.lua', 
     requires = {'kyazdani42/nvim-web-devicons', as = 'devicons'},
     cmd = {'LuaTreeToggle', 'LuaTreeOpen'} }
   use {'akinsho/nvim-bufferline.lua'}
     -- ft = {'go', 'bash', 'go', 'c_sharp', 'cpp', 'css', 'dart', 'html', 'java', 'javascript', 'jsdoc', 'json', 'lua', 'python', 'rust', 'ruby', 'toml', 'typescript'}}

 
   use {'nvim-lua/lsp-status.nvim'}
    
   use {'RishabhRD/popfix', event = 'InsertEnter'}
   use {'RishabhRD/nvim-lsputils', event = 'InsertEnter'}
   -- use {'nvim-lua/popup.nvim'}
   use {'nvim-lua/plenary.nvim'}
   use {'Xuyuanp/scrollbar.nvim'}
   use {'tjdevries/express_line.nvim', requires = {'nvim-lua/plenary.nvim', opt = true}}
   use {'kdheepak/lazygit.nvim', cmd = 'LazyGit' }
   use {'norcalli/nvim-colorizer.lua'}
 
   use {'tjdevries/nlua.nvim', ft ='lua'}
   use {'bfredl/nvim-luadev', ft ='lua'}

end)