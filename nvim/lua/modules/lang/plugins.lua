local lang = {}
local conf = require("modules.lang.config")

lang["nvim-treesitter/nvim-treesitter"] = {
    -- config = conf.nvim_treesitter,
    opt = true,
}

lang["nvim-treesitter/nvim-treesitter-textobjects"] = {
    -- after = "nvim-treesitter",
    opt = true,
}
lang["nvim-treesitter/nvim-treesitter-refactor"] = {
    -- after = "nvim-treesitter",
    opt = true,
}

lang["w0rp/ale"] = {
    event = "BufEnter", --BufWritePre
    cmd = {"ALEEnable", "ALEFix"},
    -- after = 'telescope.nvim',
    config = conf.ale,
    opt = true
}

lang["shmup/vim-sql-syntax"] = {
    ft = {"sql", "pgsql"}
}

lang["nanotee/sqls.nvim"] = {
    ft = {"sql", "pgsql"},
    config = conf.sqls,
    opt = true
}

-- lang["fatih/vim-go"] = {
--     -- ft = 'go',
--     event = "InsertEnter",
--     cmd = {"GoImport", "GoImports", "GoTest", "GoBuild", "GoFmt", "G"},
--     run = ":GoInstallBinaries",
--     config = conf.go,
--     opt = true
-- }

lang['/Users/ray.xu/github/go.nvim'] = {
  ft = 'go',
  opt = false,
  config = conf.go,
}

lang['/Users/ray.xu/github/navigator.lua'] = {
  requires = {'/Users/ray.xu/github/guihua.lua'},
  config = conf.navigator
}
-- lang['ray-x/navigator.lua'] = {
--   requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
--   config = conf.navigator
-- }

-- lang["nvim-treesitter/playground"] = {
--     after = "nvim-treesitter",
--     opt = true;
--     cmd = "TSPlaygroundToggle",
--     config = conf.playground
-- }

lang["bfredl/nvim-luadev"] = {
    opt = true,
    cmd = "Luadev",
    config = conf.luadev,
}
lang['mfussenegger/nvim-dap'] = {
  config = conf.dap,
  cmd = "Luadev",
  opt=true,

}
lang['jbyuki/one-small-step-for-vimkind'] = {
  opt=true,
  ft = {"lua"},
}

lang['nvim-telescope/telescope-dap.nvim'] = {
  config = conf.dap,
  cmd = "Telescope",
  opt=true,
}
lang['mfussenegger/nvim-dap-python'] = {ft = {"python"}}

lang["mtdl9/vim-log-highlighting"] = {ft = {"text", "log"}}
lang["michaelb/sniprun"] = {
  run = 'bash install.sh',
  opt = true,
  cmd ={'SnipRun', 'SnipReset'}
--   config = function() require'sniprun'.setup({
--   -- selected_interpreters = {},     --" use those instead of the default for the current filetype
--   -- repl_enable = {},               --" enable REPL-like behavior for the given interpreters
--   -- repl_disable = {},              --" disable REPL-like behavior for the given interpreters

--   inline_messages = 1             --" inline_message (0/1) is a one-line way to display messages
--                                   --" to workaround sniprun not being able to display anything
-- })
--end 
}

lang['gennaro-tedesco/nvim-jqx'] = {opt = true, cmd = {'JqxList', 'JqxQuery'},}
lang['windwp/nvim-ts-autotag'] = { opt = true,
  -- config = function() require'nvim-treesitter.configs'.setup {autotag = {enable = true}} end
}
lang['p00f/nvim-ts-rainbow'] = { opt = true }
return lang
