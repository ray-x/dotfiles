
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
-- vim._update_package_paths()

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

    use {'hrsh7th/vim-vsnip',   opt = true}
    use {'hrsh7th/vim-vsnip-integ',   opt = true}
    use {'nvim-treesitter/nvim-treesitter', config = 'require("treesitter")'}

    use {
        'neovim/nvim-lspconfig',
        requires = {
         {  
            "hrsh7th/nvim-compe",
            "glepnir/lspsaga.nvim",
            "RRethy/vim-illuminate",
            {"tzachar/compe-tabnine", run = './install.sh',   opt = true},
            "kosayoda/nvim-lightbulb",
            config = function()
              vim.api.nvim_command("highlight LightBulbVirtualText guifg=red")
            end
          },
          "nvim-lua/lsp-status.nvim",
          -- {"ojroques/nvim-lspfuzzy", config = require "lspfuzzy".setup {}},
          {
            "ray-x/lsp_signature.nvim",
            config = function()
              require "lsp_signature".on_attach()
            end
          },
          "RishabhRD/popfix",
          "RishabhRD/nvim-lsputils",
        },
      }

    use {'ncm2/float-preview.nvim', event = {'InsertEnter'}}
     --{'depends': {'treesitter', 'completion'},

    use {'shmup/vim-sql-syntax', ft = {'sql', 'pgsql'}}
    use {'liuchengxu/vista.vim', cmd = {'Vista'}}
    use {'kamykn/spelunker.vim'}
    use {'rhysd/vim-grammarous'}
    use {'mattn/emmet-vim', ft = {'html','css', 'js', 'ts', 'tsx'} }
    use {'Raimondi/delimitMate', event = 'InsertEnter'}
    use {'preservim/nerdcommenter',
     cmd = {'NERDCommenterComment', 'NERDCommenterToggle'},
     keys = '<Leader>c<space>' }
    -- add comments to code, tomtom/tcomment_vim is another alternative


    use {'euclio/vim-markdown-composer',
       run = 'cargo build --release',
       cmd = {'ComposerStart', 'ComposerOpen'}}
    use {'plasticboy/vim-markdown', ft = 'markdown'}
    use {'bfredl/nvim-miniyank'}

    use {'godlygeek/tabular'}

    use {'fatih/vim-go',
     ft = 'go',
     event = 'InsertEnter',
     cmd = {'GoImport', 'GoImports', 'GoTest', 'GoBuild'}, run = ':GoInstallBinaries' }

    use {'buoto/gotests-vim', ft = 'go' }

    use {'voldikss/vim-floaterm', cmd = {'FloatermNew','FloatermToggle'} }

    use {'vim-test/vim-test', cmd = {'TestNearest', 'TestFile', 'TestSuite'} }

    use {'liuchengxu/vim-clap', cmd = {'Clap'}, run = function() vim.fn['clap#installer#force_download()']() end}
    use {'simnalamburt/vim-mundo', cmd ={'MundoToggle', 'GundoToggle', 'GundoShow'}}
    use {'luochen1990/rainbow'}
    use {'Yggdroot/indentLine'}
    use {'mtdl9/vim-log-highlighting', ft={'text', 'log'}}
    use {'ray-x/vim-interestingwords', keys =  {'<Leader>u'}}
    use {'justinmk/vim-sneak', keys = {'s'}} --, cond =  '<Plug>Sneak_'
    use {'ray-x/aurora'}



    -- use {'hrsh7th/vim-vsnip', {'on_event': 'InsertEnter'}}
    -- use {'hrsh7th/vim-vsnip-integ', {'on_event': 'InsertEnter'}}

    -- """""""""""""Nvim specific""""""""""""""
    use {'kevinhwang91/rnvimr', cmd ='RnvimrToggle'}
    use {'rhysd/git-messenger.vim', cmd = 'GitMessenger'}
    --" use {'tveskag/nvim-blame-line' , cmd = {'EnableBlameLine', 'ToggleBlameLine', 'SingleBlameLine'}}

    --"""""""""""""LUA Plugins""""""""""""""
    use {'kyazdani42/nvim-tree.lua',
     requires = {'kyazdani42/nvim-web-devicons', as = 'devicons'},
     cmd = {'LuaTreeToggle', 'LuaTreeOpen'} }
    use {'akinsho/nvim-bufferline.lua'}
    use {'glepnir/galaxyline.nvim'}
     -- ft = {'go', 'bash', 'go', 'c_sharp', 'cpp', 'css', 'dart', 'html', 'java', 'javascript', 'jsdoc', 'json', 'lua', 'python', 'rust', 'ruby', 'toml', 'typescript'}}
   
    use {
      'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
      config = function() require('gitsigns').setup() end
    }
    use {'tpope/vim-fugitive', cmd = {'Gvsplit','Git','Gedit','Gstatus','Gdiffsplit','Gvdiffsplit'}}
    use {'tpope/vim-obsession'}
    use {'dhruvasagar/vim-prosession'} 
    use {'nvim-lua/popup.nvim'}
    use{'nvim-telescope/telescope.nvim'}
    use {'Xuyuanp/scrollbar.nvim'}

    use {'norcalli/nvim-colorizer.lua'} 
    use {'tjdevries/nlua.nvim', ft ='lua'}
    use {'bfredl/nvim-luadev', ft ='lua'}

end)
