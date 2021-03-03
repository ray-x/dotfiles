local tools = {}
local conf = require('modules.tools.config')

tools['kristijanhusak/vim-dadbod-ui'] = {
  cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
  config = conf.vim_dadbod_ui,
  requires = {{'tpope/vim-dadbod',opt = true}}
}

tools['editorconfig/editorconfig-vim'] = {
  opt = true,
  cmd = {'EditorConfigReload'},
  -- ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

tools['glepnir/prodoc.nvim'] = {
  event = 'BufReadPre'
}

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['kamykn/spelunker.vim'] = {opt=true, config=conf.spelunker}
tools['rhysd/vim-grammarous'] = {opt=true}

tools['euclio/vim-markdown-composer'] = {
  ft = 'markdown',
  run = 'cargo build --release',
  cmd = {'ComposerStart', 'ComposerOpen'},
  config = function() vim.g.markdown_composer_autostart = 0 end
}
tools['plasticboy/vim-markdown'] = {
  ft = 'markdown',
  requires = {'godlygeek/tabular'},
  config = conf.markdown,
}

tools['voldikss/vim-floaterm'] = {
   cmd = {'FloatermNew','FloatermToggle'},
   config = conf.floatterm
}

tools['liuchengxu/vim-clap'] = {
 cmd = {'Clap'}, run = function() vim.fn['clap#installer#download_binary']() end,
 config = conf.clap,
}


tools['rhysd/git-messenger.vim'] = { 
  cmd = 'GitMessenger', 
  config=function() 
    vim.g.git_messenger_include_diff = 'none'
    vim.g.git_messenger_always_into_popup = 1
  end,
  opt = true,
}

tools['lewis6991/gitsigns.nvim'] = {
   config = conf.gitsigns
 }
tools['tpope/vim-fugitive'] = { cmd = {'Gvsplit','Git','Gedit','Gstatus','Gdiffsplit','Gvdiffsplit'}, opt = true}

tools['dhruvasagar/vim-prosession'] = {
  requires={'tpope/vim-obsession'},
  config=function()
    vim.g.prosession_on_startup = 1
    vim.g.prosession_dir = '~/.vim/session/'
  end
} 

tools['prettier/vim-prettier'] = {
  run = 'yarn install', 
  ft={'html','css', 'js', 'ts', 'tsx', 'md'},
  config=conf.prettier,
  opt = true,
}

tools['buoto/gotests-vim'] = {
  ft = {'go'},
  opt = true,
}

tools['vim-test/vim-test'] = { cmd = {'TestNearest', 'TestFile', 'TestSuite'}, config=conf.vim_test, opt = true,}

return tools
