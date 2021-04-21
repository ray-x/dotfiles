local config = {}

local function load_env_file()
  local env_file = os.getenv("HOME") .. "/.env"
  local env_contents = {}
  if vim.fn.filereadable(env_file) ~= 1 then
    print(".env file does not exist")
    return
  end
  local contents = vim.fn.readfile(env_file)
  for _, item in pairs(contents) do
    local line_content = vim.fn.split(item, "=")
    env_contents[line_content[1]] = line_content[2]
  end
  return env_contents
end

local function load_dbs()
  local env_contents = load_env_file()
  local dbs = {}
  for key, value in pairs(env_contents) do
    if vim.fn.stridx(key, "DB_CONNECTION_") >= 0 then
      local db_name = vim.fn.split(key, "_")[3]:lower()
      dbs[db_name] = value
    end
  end
  return dbs
end

function config.vim_dadbod_ui()
  if packer_plugins["vim-dadbod"] and not packer_plugins["vim-dadbod"].loaded then
    vim.cmd [[packadd vim-dadbod]]
  end
  vim.g.db_ui_show_help = 0
  vim.g.db_ui_win_position = "left"
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_winwidth = 35
  vim.g.db_ui_save_location = os.getenv("HOME") .. "/.cache/vim/db_ui_queries"
  vim.g.dbs = load_dbs()
end

function config.vim_vista()
  vim.g["vista#renderer#enable_icon"] = 1
  vim.g.vista_disable_statusline = 1

  vim.g.vista_default_executive = "ctags"
  vim.g.vista_echo_cursor_strategy = "floating_win"
  vim.g.vista_vimwiki_executive = "markdown"
  vim.g.vista_executive_for = {
    vimwiki = "markdown",
    pandoc = "markdown",
    markdown = "toc",
    typescript = "nvim_lsp",
    typescriptreact = "nvim_lsp"
  }

  -- vim.g['vista#renderer#icons']= {
  --   function = "",
  --   variable = "כֿ",
  -- }
end

function config.clap()
  vim.g.clap_preview_size = 10
  vim.g.airline_powerline_fonts = 1
  vim.g.clap_layout = {relative = 'editor', width = "83%", row = '20%', col = "10%"} --height = "40%", row = "17%",
  vim.g.clap_popup_border = "rounded"
  vim.g.clap_selected_sign = {text = "", texthl = "ClapSelectedSign", linehl = "ClapSelected"}
  vim.g.clap_current_selection_sign = {text = "", texthl = "ClapCurrentSelectionSign", linehl = "ClapCurrentSelection"}
  vim.g.clap_always_open_preview = true
  vim.g.clap_preview_direction = 'UD'
  if not packer_plugins["nvim-compe"].loaded then
    vim.cmd [[packadd nvim-compe]]
  end
  vim.api.nvim_command("autocmd FileType clap_input call compe#setup({ 'enabled': v:false }, 0)")
end

function config.gitsigns()
  if not packer_plugins["plenary.nvim"].loaded then
    vim.cmd [[packadd plenary.nvim]]
  end
  require("gitsigns").setup {
    signs = {
      add = {hl = "GitGutterAdd", text = "│", numhl = "GitSignsAddNr"},
      change = {hl = "GitGutterChange", text = "│", numhl = "GitSignsChangeNr"},
      delete = {hl = "GitGutterDelete", text = "ﬠ", numhl = "GitSignsDeleteNr"},
      topdelete = {hl = "GitGutterDelete", text = "ﬢ", numhl = "GitSignsDeleteNr"},
      changedelete = {hl = "GitGutterChangeDelete", text = "┊", numhl = "GitSignsChangeNr"}
    },
    numhl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
      ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''},
      ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''},
      ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>'
    },
    watch_index = {
      interval = 1000
    },
    sign_priority = 6,
    status_formatter = nil -- Use default
  }
end

function config.markdown()
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_folding_level = 6
  vim.g.vim_markdown_override_foldtext = 1
  vim.g.vim_markdown_folding_style_pythonic = 1
  vim.g.vim_markdown_conceal = 1
  vim.g.vim_markdown_conceal_code_blocks = 1
  vim.g.vim_markdown_new_list_item_indent = 0
  vim.g.vim_markdown_toc_autofit = 0
  vim.g.vim_markdown_edit_url_in = "vsplit"
  vim.g.vim_markdown_strikethrough = 1
  vim.g.vim_markdown_fenced_languages = {
    "c++=javascript",
    "js=javascript",
    "json=javascript",
    "jsx=javascript",
    "tsx=javascript"
  }
end

function config.floatterm()
-- Set floaterm window's background to black
-- Set floating window border line color to cyan, and background to orange
vim.cmd("hi Floaterm guibg=black")
-- vim.cmd('hi FloatermBorder guibg=orange guifg=cyan')
vim.cmd("command! FZF FloatermNew fzf")
vim.cmd("command! NNN FloatermNew --height=0.96 --width=0.96 nnn")
vim.cmd("command! LG FloatermNew --height=0.96 --width=0.96 lazygit" )
vim.cmd(
  "command! Ranger FloatermNew --height=0.96 --width=0.96 ranger"
)

vim.g.floaterm_gitcommit = "split"
vim.g.floaterm_keymap_new = "<F19>" --S-f7
vim.g.floaterm_keymap_prev = "<F20>"
vim.g.floaterm_keymap_next = "<F21>"
vim.g.floaterm_keymap_toggle = "<F24>"
end

function config.spelunker()
  vim.g.enable_spelunker_vim_on_readonly = 0
  vim.g.spelunker_check_type = 0
  vim.g.spelunker_highlight_type = 2
  vim.g.spelunker_disable_uri_checking = 1
  vim.g.spelunker_disable_account_name_checking = 1
  vim.g.spelunker_disable_email_checking = 1
  vim.cmd("highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#53206e")
  vim.cmd("highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE")
end

function config.spellcheck()
  if not packer_plugins["kamykn/spelunker.vim"] or not packer_plugins["kamykn/spelunker.vim"].loaded then
    vim.cmd [[packadd spelunker.vim]]
  end
  vim.fn["spelunker#check"]()
end

function config.prettier()
  vim.g["prettier#autoformat"] = 1
  vim.g["prettier#autoformat_require_pragma"] = 1
  vim.g["prettier#autoformat_config_present"] = 1
  vim.g["prettier#exec_cmd_async"] = 1
  vim.g["prettier#quickfix_enabled"] = 0
  vim.api.nvim_command(
    "autocmd InsertLeave,BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync"
  )
end

function config.vim_test()
  vim.g["test#strategy"] = {
    nearest = "neovim",
    file = "neovim",
    suite = "neovim"
  }
  vim.g["test#neovim#term_position"] = "vert botright 60"
  vim.g["test#go#runner"] = "ginkgo"
  -- nmap <silent> t<C-n> :TestNearest<CR>
  -- nmap <silent> t<C-f> :TestFile<CR>
  -- nmap <silent> t<C-s> :TestSuite<CR>
  -- nmap <silent> t<C-l> :TestLast<CR>
  -- nmap <silent> t<C-g> :TestVisit<CR>
end

function config.mkdp()
  print("mkdp")
  vim.g.mkdp_command_for_global = 1
  vim.cmd(
    [[let g:mkdp_preview_options = { 'mkit': {}, 'katex': {}, 'uml': {}, 'maid': {}, 'disable_sync_scroll': 0, 'sync_scroll_type': 'middle', 'hide_yaml_meta': 1, 'sequence_diagrams': {}, 'flowchart_diagrams': {}, 'content_editable': v:true, 'disable_filename': 0 }]]
  )
end

vim.cmd(
  [["autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync"]]
)

vim.cmd("command! Gram lua require'modules.tools.config'.grammcheck()")
vim.cmd("command! Spell lua require'modules.tools.config'.spellcheck()")

return config
