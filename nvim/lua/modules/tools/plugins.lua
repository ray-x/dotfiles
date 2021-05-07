local tools = {}
local conf = require("modules.tools.config")

tools["kristijanhusak/vim-dadbod-ui"] = {
  cmd = {"DBUIToggle", "DBUIAddConnection", "DBUI", "DBUIFindBuffer", "DBUIRenameBuffer"},
  config = conf.vim_dadbod_ui,
  requires = {{"tpope/vim-dadbod", opt = true}},
  opt = true
}

tools["editorconfig/editorconfig-vim"] = {
  opt = true,
  cmd = {"EditorConfigReload"}
  -- ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

-- tools["glepnir/prodoc.nvim"] = {
--   event = "BufReadPre",
--   opt = true
-- }

tools["liuchengxu/vista.vim"] = {
  cmd = "Vista",
  setup = conf.vim_vista,
  opt = true
}

tools["kamykn/spelunker.vim"] = {opt = true, setup = conf.spelunker}
tools["rhysd/vim-grammarous"] = {opt = true, cmd = {"GrammarousCheck"}, ft = {"markdown", "txt"}, setup = conf.grammarous}

tools["plasticboy/vim-markdown"] = {
  ft = "markdown",
  requires = {"godlygeek/tabular"},
  cmd = {"Toc"},
  setup = conf.markdown,
  opt = true,
}

tools["iamcco/markdown-preview.nvim"] = {
  ft = {"markdown", 'pandoc.markdown', 'rmd'},
  cmd = {"MarkdownPreview"},
  setup = conf.mkdp,
  run = 'sh -c "cd app && yarn install"',
  opt = true,
}

-- nvim-toggleterm.lua ?
tools["voldikss/vim-floaterm"] = {
  cmd = {"FloatermNew", "FloatermToggle"},
  setup = conf.floaterm,
  opt = true
}
--
tools["liuchengxu/vim-clap"] = {
  cmd = {"Clap"},
  run = function()
    vim.fn["clap#installer#download_binary"]()
  end,
  setup = conf.clap
}

tools["rhysd/git-messenger.vim"] = {
  cmd = "GitMessenger",
  setup = function()
    vim.g.git_messenger_include_diff = "none"
    vim.g.git_messenger_always_into_popup = 1
  end,
  opt = true
}

tools["sindrets/diffview.nvim"] = {
  cmd = "DiffviewOpen",
  config = conf.diffview
}

tools["lewis6991/gitsigns.nvim"] = {
  config = conf.gitsigns,
  -- keys = {']c', '[c'},
  -- opt = true,
}

tools["f-person/git-blame.nvim"] = {
  setup = function ()
    vim.g.gitblame_enabled = 0
  end,
  opt = true,
  cmd = 'GitBlameToggle'

}
tools["tpope/vim-fugitive"] = {cmd = {"Gvsplit", "Git", "Gedit", "Gstatus", "Gdiffsplit", "Gvdiffsplit"}, opt = true}

-- tools["tpope/vim-obsession"] ={} -- for prosession
tools["dhruvasagar/vim-prosession"] = {
  -- event = "BufReadPre",
  requires = {"tpope/vim-obsession", opt=false},
  -- after = 'vim-obsession',
  config = function()
    vim.g.prosession_on_startup = 1
    vim.g.prosession_dir = "~/.vim/session/"
  end,
  opt = false,
}

tools["prettier/vim-prettier"] = {
  run = "yarn install",
  -- ft = {
  --   "html",
  --   "css",
  --   "js",
  --   "ts",
  --   "tsx",
  --   "md",
  --   "javascript",
  --   "typescript",
  --   "css",
  --   "less",
  --   "scss",
  --   "json",
  --   "graphql",
  --   "markdown",
  --   "vue",
  --   "yaml",
  --   "html"
  -- },
  cmd = {"Prettier", "PrettierAsync", "PrettierPartial"},
  config = conf.prettier,
  opt = true
}

--
tools["brooth/far.vim"] = {cmd = {"Farr", "Farf"}, config = conf.far, opt = true} --brooth/far.vim
-- tools["windwp/nvim-spectre"] = {opt = true, config=conf.spectre, keys = {'<Leader>S', '<Leader>s'},requires = {{'nvim-lua/plenary.nvim'} , {'nvim-lua/popup.nvim'}}}
tools["vim-test/vim-test"] = {cmd = {"TestNearest", "TestFile", "TestSuite", "Ultest", "UltestNearest", "UltestSummary", "UltestDebugNearest"}, setup = conf.vim_test, opt = true}


tools["rcarriga/vim-ultest"] ={
  run = ":UpdateRemotePlugins", 
  -- requires = {"vim-test/vim-test"}, 
  cmd = {"Ultest", "UltestNearest", "UltestSummary", "UltestDebugNearest"}, 
  opt = true
}  --, requires = {"janko/vim-test"},

return tools
