local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
K = {}
local function check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keys = {
    -- ["n|F13"]  = map_cmd("<S-F1>"),
    -- ["n|F14"]  = map_cmd("<S-F2>"),
    -- ["n|F15"]  = map_cmd("<S-F3>"),
    -- ["n|F16"]  = map_cmd("<S-F4>"),
    -- ["n|F17"]  = map_cmd("<S-F5>"),
    -- ["n|F18"]  = map_cmd("<S-F6>"),
    -- ["n|F19"]  = map_cmd("<S-F7>"),
    -- ["n|F20"]  = map_cmd("<S-F8>"),
    -- ["n|F21"]  = map_cmd("<S-F9>"),
    -- ["n|F22"]  = map_cmd("<S-F10>"),
    -- ["n|F23"]  = map_cmd("<S-F11>"),
    -- ["n|F24"]  = map_cmd("<S-F12>"),
--
--
    -- pack?
    -- ["n|<Leader>tr"]     = map_cr("call dein#recache_runtimepath()"):with_noremap():with_silent(),
    -- ["n|<Leader>tf"]     = map_cu('DashboardNewFile'):with_noremap():with_silent(),
    -- gitsign?
    ["n|[g"]             = map_cr("<cmd> lua require\"gitsigns\".prev_hunk()"):with_noremap():with_silent(),
    ["n|]g"]             = map_cr("<cmd> lua require\"gitsigns\".next_hunk()"):with_noremap():with_silent(),
--
    -- Lsp mapp work when insertenter and lsp start
--
    ["n|<Leader>tc"]     = map_cu('Clap colors'):with_noremap():with_silent(),
    ["n|<Leader>bb"]     = map_cu('Clap buffers'):with_noremap():with_silent(),
    ["n|<Leader>fa"]     = map_cu('Clap grep'):with_noremap():with_silent(),
    ["n|<Leader>fb"]     = map_cu('Clap marks'):with_noremap():with_silent(),
    ["n|<C-x><C-f>"]     = map_cu('Clap filer'):with_noremap():with_silent(),
    ["n|<Leader>ff"]     = map_cu('Clap files ++finder=rg --ignore --hidden --files'):with_noremap():with_silent(),
    ["n|<M-g>"]          = map_cu('Clap gfiles'):with_noremap():with_silent(),
    ["n|<Leader>fw"]     = map_cu('Clap grep ++query=<Cword>'):with_noremap():with_silent(),
    ["n|<M-h>"]          = map_cu('Clap history'):with_noremap():with_silent(),
    ["n|<Leader>fW"]     = map_cu('Clap windows'):with_noremap():with_silent(),
    ["n|<Leader>fl"]     = map_cu('Clap loclist'):with_noremap():with_silent(),
    ["n|<Leader>fu"]     = map_cu('Clap git_diff_files'):with_noremap():with_silent(),
    ["n|<Leader>fv"]     = map_cu('Clap grep ++query=@visual'):with_noremap():with_silent(),
    ["n|<Leader>fd"]     = map_cu('Clap dotfiles'):with_noremap():with_silent(),
    ["n|Rn"]             = map_cr('Lspsaga rename'):with_noremap():with_silent(),
    ["n|gr"]             = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
    ["n|<Leader>fh"]     = map_cu('Clap command_history'):with_noremap():with_silent(),
--
    -- Plugin QuickRun
    -- ["n|<Leader>r"]     = map_cr("<cmd> lua require'selfunc'.run_command()"):with_noremap():with_silent(),
    -- Plugin Vista
    ["n|<Leader>v"]      = map_cu('Vista!!'):with_noremap():with_silent(),
    -- Plugin SplitJoin
    ["n|<m-j>"]          = map_cr('SplitjoinJoin'),
    ["n|<m-s>"]          = map_cr('SplitjoinSplit'),
    ["n|;"]              = map_cmd("<Plug>Sneak_;"):with_silent(),
  };
--
-- undo leader mapping
vim.g.mapleader = "\\"
vim.cmd([[vnoremap  <leader>y  "+y]])
vim.cmd([[nnoremap  <leader>Y  "+yg_]])
vim.cmd([[vnoremap  <M-c>  "+y]])
vim.cmd([[nnoremap  <M-c>  "+yg_]])
-- vim.cmd([[unmap sa]])
-- vim.cmd([[unmap sd]])
-- vim.cmd([[unmap sr]])
-- vim.cmd([[unmap <Leader>ss]])
-- vim.cmd([[unmap <Leader>sl]])
-- vim.cmd([[xunmap I]])
-- vim.cmd([[xunmap gI]])
-- vim.cmd([[xunmap A]])
--
vim.cmd([[nmap ; <Plug>Sneak_;]])
--
--
bind.nvim_load_mapping(keys)
--
return K
