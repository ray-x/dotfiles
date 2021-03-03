local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map = {
    ["i|<TAB>"]      = map_cmd('v:lua.tab_complete()'):with_expr():with_silent(),
    ["i|<S-TAB>"]    = map_cmd('v:lua.s_tab_complete()'):with_silent():with_expr(),
    -- ["i|<CR>"]       = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),
    -- person keymap
    ["n|mf"]             = map_cr("<cmd>lua require('internal.fsevent').file_event()<CR>"):with_silent():with_nowait():with_noremap();
    ["n|gb"]             = map_cr("BufferLinePick"):with_noremap():with_silent(),
    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"]     = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<C-f>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|<C-b>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|[e"]             = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
    ["n|]e"]             = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
    ["n|K"]              = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
    ["n|ga"]             = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
    ["v|ga"]             = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
    ["n|gd"]             = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),
    ["n|gD"]             = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    ["n|gs"]             = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
    ["n|gr"]             = map_cr('Lspsaga rename'):with_noremap():with_silent(),
    ["n|gh"]             = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
    ["n|gt"]             = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>cw"]     = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>ce"]     = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
    ["n|<Leader>ct"]      = map_args("Template"),
    ["n|<Leader>tf"]     = map_cu('DashboardNewFile'):with_noremap():with_silent(),
    -- mhinz/vim-signify
    ["n|[g"]             = map_cmd("<plug>(signify-next-hunk)"),
    ["n|]g"]             = map_cmd("<plug>(signify-prev-hunk)"),
    -- Plugin nvim-tree
    ["n|<Leader>e"]      = map_cr('NvimTreeToggle'):with_noremap():with_silent(),
    ["n|<Leader>F"]      = map_cr('NvimTreeFindFile'):with_noremap():with_silent(),
    -- Plugin MarkdownPreview
    ["n|<Leader>om"]     = map_cu('MarkdownPreview'):with_noremap():with_silent(),
    -- Plugin DadbodUI
    ["n|<Leader>od"]     = map_cr('DBUIToggle'):with_noremap():with_silent(),
    -- Plugin Floaterm
    ["n|<A-d>"]          = map_cu('Lspsaga open_floaterm'):with_noremap():with_silent(),
    ["t|<A-d>"]          = map_cu([[<C-\><C-n>:Lspsaga close_floaterm<CR>]]):with_noremap():with_silent(),
    ["n|<Leader>g"]      = map_cu("Lspsaga open_floaterm lazygit"):with_noremap():with_silent(),
    -- Far.vim
    ["n|<Leader>fz"]     = map_cr('Farf'):with_noremap():with_silent();
    ["v|<Leader>fz"]     = map_cr('Farf'):with_noremap():with_silent();
    -- Plugin Telescope
    ["n|<Leader>bb"]     = map_cu('Telescope buffers'):with_noremap():with_silent(),
    ["n|<Leader>fa"]     = map_cu('DashboardFindWord'):with_noremap():with_silent(),
    ["n|<Leader>fb"]     = map_cu('Telescope file_browser'):with_noremap():with_silent(),
    ["n|<Leader>ff"]     = map_cu('DashboardFindFile'):with_noremap():with_silent(),
    ["n|<Leader>fg"]     = map_cu('Telescope git_files'):with_noremap():with_silent(),
    ["n|<Leader>fw"]     = map_cu('Telescope grep_string'):with_noremap():with_silent(),
    ["n|<Leader>fh"]     = map_cu('DashboardFindHistory'):with_noremap():with_silent(),
    ["n|<Leader>fl"]     = map_cu('Telescope loclist'):with_noremap():with_silent(),
    ["n|<Leader>fc"]     = map_cu('Telescope git_commits'):with_noremap():with_silent(),
    ["n|<Leader>ft"]     = map_cu('Telescope help_tags'):with_noremap():with_silent(),
    ["n|<Leader>fd"]     = map_cu('Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles'):with_noremap():with_silent(),
    ["n|<Leader>fs"]     = map_cu('Telescope gosource'):with_noremap():with_silent(),
    -- prodoc
    ["n|gcc"]            = map_cu('ProComment'):with_noremap():with_silent(),
    ["x|gcc"]            = map_cr('ProComment'),
    ["n|gcj"]            = map_cu('ProDoc'):with_silent():with_silent(),
    -- Plugin acceleratedjk
    ["n|j"]              = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
    ["n|k"]              = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),
    -- Plugin QuickRun
    ["n|<Leader>r"]     = map_cr("<cmd> lua require'internal.quickrun'.run_command()"):with_noremap():with_silent(),
    -- Plugin Vista
    ["n|<Leader>v"]      = map_cu('Vista'):with_noremap():with_silent(),
    -- Plugin vim-operator-surround
    ["n|sa"]             = map_cmd("<Plug>(operator-surround-append)"):with_silent(),
    ["n|sd"]             = map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
    ["n|sr"]             = map_cmd("<Plug>(operator-surround-replace)"):with_silent(),
    -- Plugin hrsh7th/vim-eft
    ["n|;"]              = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["x|;"]              = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["n|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["x|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["o|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["n|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["x|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["o|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    -- Plugin vim_niceblock
    ["x|I"]              = map_cmd("v:lua.enhance_nice_block('I')"):with_expr(),
    ["x|gI"]             = map_cmd("v:lua.enhance_nice_block('gI')"):with_expr(),
    ["x|A"]              = map_cmd("v:lua.enhance_nice_block('A')"):with_expr(),
};




bind.nvim_load_mapping( {
  -- Lsp mapp work when insertenter and lsp start
  
  -- dein
  ["n|<Leader>tr"]     = map_cr("call dein#recache_runtimepath()"):with_noremap():with_silent(),
  ["n|<Leader>tf"]     = map_cu('DashboardNewFile'):with_noremap():with_silent(),
  -- mhinz/vim-signify
  ["n|[g"]             = map_cmd("<plug>(signify-next-hunk)"),
  ["n|]g"]             = map_cmd("<plug>(signify-prev-hunk)"),
  -- Plugin Defx
  -- ["n|<Leader>e"]      = map_cu([[Defx -resume -toggle -buffer-name=tab`tabpagenr()`]]):with_noremap():with_silent(),
  -- ["n|<Leader>F"]      = map_cu([[Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`]]):with_noremap():with_silent(),
  -- Plugin MarkdownPreview
  -- ["n|<Leader>om"]     = map_cu('MarkdownPreview'):with_noremap():with_silent(),
  -- Plugin DadbodUI
  -- ["n|<Leader>od"]     = map_cr('DBUIToggle'):with_noremap():with_silent(),
  -- Plugin Floaterm
  -- ["n|<C-t>t"]          = map_cu("lua require('selfunc').float_terminal()"):with_noremap():with_silent(),
  -- ["t|<C-t>t"]          = map_cu([[<C-\><C-n>:lua require('selfunc').close_float_terminal()<CR>]]):with_noremap():with_silent(),

  -- Lsp mapp work when insertenter and lsp start
  ["n|<C-f>"]          = map_cmd("<cmd>lua require('lspsaga.hover').scroll_in_hover(1)<CR>"):with_silent():with_noremap():with_nowait(),
  ["n|<C-b>"]          = map_cmd("<cmd>lua require('lspsaga.hover').scroll_in_hover(-1)<CR>"):with_silent():with_noremap():with_nowait(),
  ["n|[d"]             = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
  ["n|]d"]             = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
  ["n|K"]              = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
  ["n|ga"]             = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
  ["v|ga"]             = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
  ["n|gd"]             = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),
  ["n|gD"]             = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
  ["n|gs"]             = map_cmd("<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>"):with_silent():with_noremap():with_nowait(),
  -- ["n|gr"]             = map_cr('Lspsaga rename'):with_noremap():with_silent(),
  ["n|gh"]             = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
  ["n|gt"]             = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
  ["n|<Leader>cw"]     = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
  ["n|<Leader>ce"]     = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
  ["n|<m-n>"]          = map_cr('lua require"illuminate".next_reference{wrap=true}'):with_noremap():with_silent(),
  ["n|<m-p>"]          = map_cr('lua require"illuminate".next_reference{reverse=true,wrap=true}'):with_noremap():with_silent(),
  ["n|<m-l>"]          = map_cr('ALEEnable | ALELint'):with_noremap():with_silent(),
  ["n|gcj"]          = map_cr('ProDoc'):with_noremap():with_silent(),
  ["n|gcc"]          = map_cr('ProComment'):with_noremap():with_silent(),
  ["x|gcc"]          = map_cr('ProComment'):with_noremap():with_silent(),

  -- ["n|<Leader>ct"]      = map_args("Template"),
  --   ["n|<C-t>r"]     = map_cr("<cmd> lua require'selfunc'.run_command()"):with_noremap():with_silent(),
  -- ["n|<Leader>g"]      = map_cu("lua require('selfunc').float_terminal('lazygit')"):with_noremap():with_silent(),
  -- Far.vim  Clap grep + cdo/cfdo
  -- Plugin Clap
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
  -- ["n|<Leader>bb"]     = map_cu('Telescope buffers'):with_noremap():with_silent(),
  -- ["n|<Leader>fa"]     = map_cu('Telescope grep_string'):with_noremap():with_silent(),
  -- ["n|<Leader>fb"]     = map_cu('Telescope marks'):with_noremap():with_silent(),
  -- ["n|<Leader>ff"]     = map_cu('Telescope find_files'):with_noremap():with_silent(),
  -- ["n|<Leader>fg"]     = map_cu('Telescope git_files'):with_noremap():with_silent(),
  -- -- ["n|<Leader>fw"]     = map_cu('lua require"telescope.builtin".grep_string{search=true}'):with_noremap():with_silent(),
  -- ["n|<Leader>fw"]     = map_cu('lua require"telescope.builtin".grep_string{search=false}'):with_noremap():with_silent(),
  -- ["n|<Leader>rg"]     = map_cu('lua require"telescope.builtin".live_grep{}'):with_noremap():with_silent(),
  -- ["n|<Leader>fh"]     = map_cu('Telescope oldfiles'):with_noremap():with_silent(),
  -- ["n|<Leader>fl"]     = map_cu('Telescope loclist'):with_noremap():with_silent(),
  -- ["n|<Leader>fd"]     = map_cu('lua require"telescope".load_dotfiles()'):with_noremap():with_silent(),
  -- ["n|<Leader>fs"]      = map_cu('Clap gosource'):with_noremap():with_silent(),
  -- Plugin acceleratedjk
  -- ["n|j"]              = map_cmd('<Plug>(accelerated_jk_gj)'):with_silent(),
  -- ["n|k"]              = map_cmd('<Plug>(accelerated_jk_gk)'):with_silent(),
  -- Plugin QuickRun
  ["n|<Leader>r"]     = map_cr("lua require'selfunc'.run_command()"):with_noremap():with_silent(),
  -- Plugin Vista 
  ["n|<Leader>v"]      = map_cu('Vista!!'):with_noremap():with_silent(),
  -- Plugin SplitJoin
  ["n|<m-j>"]             = map_cr('SplitjoinJoin'),
  ["n|<m-k>"]             = map_cr('SplitjoinSplit'),
})



bind.nvim_load_mapping(plug_map)
