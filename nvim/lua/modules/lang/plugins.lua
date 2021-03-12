local lang = {}
local conf = require("modules.lang.config")

lang["nvim-treesitter/nvim-treesitter"] = {
    config = conf.nvim_treesitter
}

lang["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
    opt = false
}

lang["w0rp/ale"] = {
    event = "BufWritePre",
    cmd = {"ALEEnable", "ALEFix"},
    -- after = 'telescope.nvim',
    config = conf.ale,
     --'vim.cmd[[ALEEnable]]',
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

-- lang["arp242/gopher.vim"] = {
lang["Users/ray.xu/github/arp242/gopher.vim"] = {
    -- ft = 'go',
    config = conf.gopher,
}

lang["nvim-treesitter/playground"] = {
    after = "nvim-treesitter",
    opt = true;
    cmd = "TSPlaygroundToggle",
    config = conf.playground
}

lang["bfredl/nvim-luadev"] = {
    opt = true;
    cmd = "Luadev",
    config = conf.luadev,
    opt = true,
}




lang["mtdl9/vim-log-highlighting"] = {ft = {"text", "log"}}

return lang
