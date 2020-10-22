local M = {}
local vim = vim
local mapping = {}
local rhs_options = {}

function mapping:new()
  local instance = {}
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

function mapping:load_vim_define()
  self.vim= {
    -- Vim map
    ["n|<C-x>k"]     = map_cr('Bdelete'):with_noremap(),
    ["n|<C-s>"]      = map_cu('write'):with_noremap(),
    ["n|Y"]          = map_cmd('y$'),
    ["n|]w"]         = map_cu('WhitespaceNext'):with_noremap(),
    ["n|[w"]         = map_cu('WhitespacePrev'):with_noremap(),
    ["n|]b"]         = map_cu('bp'):with_noremap(),
    ["n|[b"]         = map_cu('bn'):with_noremap(),
    ["n|<Space>cw"]  = map_cu([[silent! keeppatterns %substitute/\s\+$//e]]):with_noremap():with_silent(),
    ["n|<C-h>"]      = map_cmd('<C-w>h'):with_noremap(),
    ["n|<C-l>"]      = map_cmd('<C-w>l'):with_noremap(),
    ["n|<C-j>"]      = map_cmd('<C-w>j'):with_noremap(),
    ["n|<C-k>"]      = map_cmd('<C-w>k'):with_noremap(),
    ["n|<C-w>["]     = map_cr('vertical resize -5'),
    ["n|<C-w>]"]     = map_cr('vertical resize +5'),
    ["n|<Leader>ss"] = map_cu('SessionSave'):with_noremap(),
    ["n|<Leader>sl"] = map_cu('SessionLoad'):with_noremap(),
  -- Insert
    ["i|<C-w>"]      = map_cmd('<C-[>diwa'):with_noremap(),
    ["i|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
    ["i|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
    ["i|<C-k>"]      = map_cmd('<ESC>d$a'):with_noremap(),
    ["i|<C-u>"]      = map_cmd('<C-G>u<C-U>'):with_noremap(),
    ["i|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
    ["i|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
    ["i|<C-a>"]      = map_cmd('<ESC>^i'):with_noremap(),
    ["i|<C-o>"]      = map_cmd('<Esc>o'):with_noremap(),
    ["i|<C-s>"]      = map_cmd('<Esc>:w<CR>'),
    ["i|<C-q>"]      = map_cmd('<Esc>:wq<CR>'),
    ["i|<C-e>"]      = map_cmd([[pumvisible() ? "\<C-e>" : "\<End>"]]):with_noremap():with_expr(),
    -- TODO Wrap line
    ["i|<TAB>"]      = map_cmd([[pumvisible() ? "\<C-n>" : vsnip#available(1) ?"\<Plug>(vsnip-expand-or-jump)" : v:lua.check_back_space() ? "\<TAB>" : completion#trigger_completion()]]):with_expr():with_silent(),
    ["i|<S-TAB>"]    = map_cmd([[pumvisible() ? "\<C-p>" : "\<C-h>"]]):with_noremap():with_expr(),
    ["i|<CR>"]       = map_cmd([[pumvisible() ? complete_info()["selected"] != "-1" ?"\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>":(delimitMate#WithinEmptyPair() ? "\<Plug>delimitMateCR" : "\<CR>")]]):with_expr(),
  -- command line
    ["c|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
    ["c|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
    ["c|<C-a>"]      = map_cmd('<Home>'):with_noremap(),
    ["c|<C-e>"]      = map_cmd('<End>'):with_noremap(),
    ["c|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
    ["c|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
    ["c|<C-t>"]      = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
  }
end

function mapping:load_plugin_define()
  self.plugin = {
    -- Lsp mapp work when insertenter and lsp start
    ["n|[e"]             = map_cmd("<cmd>lua require'lsp.diagnostic'.lsp_jump_diagnostic_next()<CR>"):with_noremap():with_silent(),
    ["n|]e"]             = map_cmd("<cmd>lua require'lsp.diagnostic'.lsp_jump_diagnostic_prev()<CR>"):with_noremap():with_silent(),
    ["n|K"]              = map_cmd("<cmd>lua vim.lsp.buf.hover()<CR>"):with_noremap():with_silent(),
    ["n|ga"]             = map_cmd("<cmd>lua vim.lsp.buf.code_action()<CR>"):with_noremap():with_silent(),
    ["n|gd"]             = map_cmd("<cmd>lua require'lsp.provider'.preview_definiton()<CR>"):with_noremap():with_silent(),
    ["n|gD"]             = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    ["n|gs"]             = map_cmd("<cmd>lua vim.lsp.buf.signature_help()<CR>"):with_noremap():with_silent(),
    ["n|gr"]             = map_cmd("<cmd>lua vim.lsp.buf.references()<CR>"):with_noremap():with_silent(),
    ["n|gh"]             = map_cmd("<cmd>lua require'lsp.provider'.lsp_peek_references()<CR>"):with_noremap():with_silent(),
    ["n|gt"]             = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>cw"]     = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>ce"]     = map_cmd("<cmd>lua require'lsp.diagnostic'.show_buf_diagnostics()<CR>"):with_noremap():with_silent(),
    -- dein
    ["n|<Leader>tr"]     = map_cr("call dein#recache_runtimepath()"):with_noremap():with_silent(),
    ["n|<Leader>tf"]     = map_cu('DashboardNewFile'):with_noremap():with_silent(),
    -- mhinz/vim-signify
    ["n|[g"]             = map_cmd("<plug>(signify-next-hunk)"),
    ["n|]g"]             = map_cmd("<plug>(signify-prev-hunk)"),
    -- Plugin Defx
    ["n|<Leader>e"]      = map_cu([[Defx -resume -toggle -buffer-name=tab`tabpagenr()`]]):with_noremap():with_silent(),
    ["n|<Leader>F"]      = map_cu([[Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`]]):with_noremap():with_silent(),
    -- Plugin MarkdownPreview
    ["n|<Leader>om"]     = map_cu('MarkdownPreview'):with_noremap():with_silent(),
    -- Plugin DadbodUI
    ["n|<Leader>od"]     = map_cr('DBUIToggle'):with_noremap():with_silent(),
    -- Plugin Floaterm
    ["n|<A-d>"]          = map_cu("lua require('selfunc').float_terminal()"):with_noremap():with_silent(),
    ["t|<A-d>"]          = map_cu([[<C-\><C-n>:lua require('selfunc').close_float_terminal()<CR>]]):with_noremap():with_silent(),
    ["n|<Leader>g"]      = map_cu("lua require('selfunc').float_terminal('lazygit')"):with_noremap():with_silent(),
    -- Far.vim
    ["n|<Leader>fz"]     = map_cr('Farf'):with_noremap():with_silent();
    ["v|<Leader>fz"]     = map_cr('Farf'):with_noremap():with_silent();
    -- Plugin Clap
    ["n|<Leader>tc"]     = map_cu('Clap colors'):with_noremap():with_silent(),
    ["n|<Leader>bb"]     = map_cu('Clap buffers'):with_noremap():with_silent(),
    ["n|<Leader>fa"]     = map_cu('Clap grep'):with_noremap():with_silent(),
    ["n|<Leader>fb"]     = map_cu('Clap marks'):with_noremap():with_silent(),
    ["n|<C-x><C-f>"]     = map_cu('Clap filer'):with_noremap():with_silent(),
    ["n|<Leader>ff"]     = map_cu('Clap files ++finder=rg --ignore --hidden --files'):with_noremap():with_silent(),
    ["n|<Leader>fg"]     = map_cu('Clap gfiles'):with_noremap():with_silent(),
    ["n|<Leader>fw"]     = map_cu('Clap grep ++query=<Cword>'):with_noremap():with_silent(),
    ["n|<Leader>fh"]     = map_cu('Clap history'):with_noremap():with_silent(),
    ["n|<Leader>fW"]     = map_cu('Clap windows'):with_noremap():with_silent(),
    ["n|<Leader>fl"]     = map_cu('Clap loclist'):with_noremap():with_silent(),
    ["n|<Leader>fu"]     = map_cu('Clap git_diff_files'):with_noremap():with_silent(),
    ["n|<Leader>fv"]     = map_cu('Clap grep ++query=@visual'):with_noremap():with_silent(),
    ["n|<Leader>fd"]     = map_cu('Clap dotfiles'):with_noremap():with_silent(),
    ["n|<Leader>fs"]      = map_cu('Clap gosource'):with_noremap():with_silent(),
    -- Plugin acceleratedjk
    ["n|j"]              = map_cmd('<Plug>(accelerated_jk_gj)'):with_silent(),
    ["n|k"]              = map_cmd('<Plug>(accelerated_jk_gk)'):with_silent(),
    -- Plugin QuickRun
    ["n|<Leader>r"]     = map_cr("<cmd> lua require'selfunc'.run_command()"):with_noremap():with_silent(),
    -- Plugin Vista
    ["n|<Leader>v"]      = map_cu('Vista!!'):with_noremap():with_silent(),
    -- Plugin SplitJoin
    ["n|sj"]             = map_cr('SplitjoinJoin'),
    ["n|sk"]             = map_cr('SplitjoinSplit'),
    -- Plugin vim-operator-replace
    ["x|p"]              = map_cmd("<Plug>(operator-replace)"),
    -- Plugin vim-operator-surround
    ["n|sa"]             = map_cmd("<Plug>(operator-surround-append)"):with_silent(),
    ["n|sd"]             = map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
    ["n|sr"]             = map_cmd("<Plug>(operator-surround-replace)"):with_silent(),
    -- Plugin hrsh7th/vim-eft
    ["n|;"]              = map_cmd("<Plug>(eft-repeat)"),
    ["x|;"]              = map_cmd("<Plug>(eft-fepeat)"),
    ["n|f"]              = map_cmd("<Plug>(eft-f)"),
    ["x|f"]              = map_cmd("<Plug>(eft-f)"),
    ["o|f"]              = map_cmd("<Plug>(eft-f)"),
    ["n|F"]              = map_cmd("<Plug>(eft-F)"),
    ["x|F"]              = map_cmd("<Plug>(eft-F)"),
    ["o|F"]              = map_cmd("<Plug>(eft-F)"),
  };
end

function M.nvim_load_mapping(mapping)
  for _,v in pairs(mapping) do
    for key,value in pairs(v) do
      local mode,keymap = key:match("([^|]*)|?(.*)")
      if type(value) == 'table' then
        local rhs = value.cmd
        local options = value.options
        vim.fn.nvim_set_keymap(mode,keymap,rhs,options)
      end
    end
  end
end

function rhs_options:new()
  local instance = {
    cmd = '',
    options = {
      noremap = false,
      silent = false,
      expr = false,
    }
  }
  setmetatable(instance,self)
  self.__index = self
  return instance
end

function rhs_options:map_cmd(cmd_string)
  self.cmd = cmd_string
  return self
end

function rhs_options:map_cr(cmd_string)
  self.cmd = (":%s<CR>"):format(cmd_string)
  return self
end

function rhs_options:map_cu(cmd_string)
  self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
  return self
end

function rhs_options:with_silent()
  self.options.silent = true
  return self
end

function rhs_options:with_noremap()
  self.options.noremap = true
  return self
end

function rhs_options:with_expr()
  self.options.expr = true
  return self
end

function map_cr(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cr(cmd_string)
end

function map_cmd(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cmd(cmd_string)
end

function map_cu(cmd_string)
  local ro = rhs_options:new()
  return ro:map_cu(cmd_string)
end


function M.load_mapping()
  local map = mapping:new()
  map:load_vim_define()
  map:load_plugin_define()
  M.nvim_load_mapping(map)
end

return M
