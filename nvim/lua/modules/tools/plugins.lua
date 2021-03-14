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

tools["glepnir/prodoc.nvim"] = {
  event = "BufReadPre",
  opt = true
}

tools["liuchengxu/vista.vim"] = {
  cmd = "Vista",
  config = conf.vim_vista,
  opt = true
}

tools["kamykn/spelunker.vim"] = {opt = true, config = conf.spelunker}
-- tools["rhysd/vim-grammarous"] = {opt = true, ft = {"markdown", "txt"}, config = conf.grammarous}

tools["plasticboy/vim-markdown"] = {
  ft = "markdown",
  requires = {"godlygeek/tabular"},
  cmd = {"Toc"},
  config = conf.markdown,
  opt = true,
}

tools["iamcco/markdown-preview.nvim"] = {
  ft = {"markdown", 'pandoc.markdown', 'rmd'},
  cmd = {"MarkdownPreview"},
  config = conf.mkdp,
  run = 'sh -c "cd app && yarn install"',
  opt = true,
}

-- tools["voldikss/vim-floaterm"] = {
--   cmd = {"FloatermNew", "FloatermToggle"},
--   config = conf.floatterm,
--   opt = true
-- }
--
tools["liuchengxu/vim-clap"] = {
  cmd = {"Clap"},
  run = function()
    vim.fn["clap#installer#download_binary"]()
  end,
  config = conf.clap
}

tools["RishabhRD/nvim-finder"] = {
  cmd={"Finder"},
  requires = {{"RishabhRD/popfix"}},
  config = function() vim.g.enable_finder_native_sorter = false end
}
-- tools["rafcamlet/nvim-whid"] =
-- {
-- }
-- tools["amirrezaask/fuzzy.nvim"] =
-- {
--   config = function()
--     vim.g.fuzzy_options = {
--     -- location = "center",
--     width = 50,
--     height = 50
--   }
--   end
-- }

tools["rhysd/git-messenger.vim"] = {
  cmd = "GitMessenger",
  config = function()
    vim.g.git_messenger_include_diff = "none"
    vim.g.git_messenger_always_into_popup = 1
  end,
  opt = true
}

tools["lewis6991/gitsigns.nvim"] = {
  config = conf.gitsigns
}
tools["tpope/vim-fugitive"] = {cmd = {"Gvsplit", "Git", "Gedit", "Gstatus", "Gdiffsplit", "Gvdiffsplit"}, opt = true}

tools["dhruvasagar/vim-prosession"] = {
  requires = {"tpope/vim-obsession"},
  config = function()
    vim.g.prosession_on_startup = 1
    vim.g.prosession_dir = "~/.vim/session/"
  end
}

tools["prettier/vim-prettier"] = {
  run = "yarn install",
  ft = {
    "html",
    "css",
    "js",
    "ts",
    "tsx",
    "md",
    "javascript",
    "typescript",
    "css",
    "less",
    "scss",
    "json",
    "graphql",
    "markdown",
    "vue",
    "yaml",
    "html"
  },
  cmd = {"Prettier", "PrettierAsync", "PrettierPartial"},
  config = conf.prettier,
  opt = true
}

-- tools["buoto/gotests-vim"] = {
--   ft = {"go"},
--   cmd = {"GoTests", "GoTestsAll"},
--   opt = true
-- }
--
tools["vim-test/vim-test"] = {cmd = {"TestNearest", "TestFile", "TestSuite"}, config = conf.vim_test, opt = true}

return tools
