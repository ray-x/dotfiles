local config = {}

function config.galaxyline()
  require('modules.ui.eviline')
end

local winwidth = function ()
  return vim.api.nvim_call_function('winwidth', {0})
end

function config.nvim_bufferline()
  require('bufferline').setup{
    options = {
      view = "multiwindow",
      numbers ="none",  --"none" | "ordinal" | "buffer_id",
      number_style = "superscript" ,
      mappings = true ,
      buffer_close_icon= '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 14,
      max_prefix_length = 10,
      tab_size = 16,
      diagnostics = "nvim_lsp",
      show_buffer_close_icons = false,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and "" or ""  -- "" or ""
        return "" .. icon .. count
      end,
      show_buffer_close_icons = false,
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      -- 'extension' | 'directory' |
      sort_by = 'directory'
    }
  }
end

-- function config.dashboard()
--   local home = os.getenv('HOME')
--   vim.g.dashboard_preview_command = 'cat'
--   vim.g.dashboard_preview_pipeline = 'lolcat'
--   vim.g.dashboard_preview_file = home .. '/.config/nvim/static/pokemon.txt'
--   vim.g.dashboard_preview_file_height = 14
--   vim.g.dashboard_preview_file_width = 80
--   vim.g.dashboard_default_executive = 'telescope'
--   vim.g.dashboard_custom_section = {
--     last_session = {
--       description = {'  Recently laset session                  SPC s l'},
--       command =  'SessionLoad'},
--     find_history = {
--       description = {'  Recently opened files                   SPC f h'},
--       command =  'DashboardFindHistory'},
--     find_file  = {
--       description = {'  Find  File                              SPC f f'},
--       command = 'DashboardFindFile'},
--     new_file = {
--      description = {'  New   File                              SPC t f'},
--      command =  'DashboardNewFile'},
--     find_word = {
--      description = {'  Find  word                              SPC f w'},
--      command = 'DashboardFindWord'},
--     find_dotfiles = {
--      description = {'  Open Personal dotfiles                  SPC f d'},
--      command = 'Telescope dotfiles path=' .. home ..'/.dotfiles'},
--     go_source = {
--      description = {'  Find Go Source Code                     SPC f s'},
--      command = 'Telescope gosource'},
--   }
-- end

function config.nvim_tree()
  vim.cmd([[nmap <F13> :NvimTreeToggle<CR>]])
  vim.cmd([[autocmd Filetype LuaTree set cursorline]])
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_width = 28
  vim.g.nvim_tree_auto_close = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_width_allow_resize  = 1
  vim.g.nvim_tree_tab_open = 1
  vim.g.nvim_tree_bindings = {
    ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
    ["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
    ["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
  }
  vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = "✗",
      staged = "✓",
      unmerged = "",
      renamed = "➜",
      untracked = "★"
      },
    folder = {
      default = "",
      open = "",
      symlink = "",
      }
    }
end

-- function config.vim_signify()
--   vim.g.signify_sign_add = '▋'
--   vim.g.signify_sign_change = '▋'
--   vim.g.signify_sign_delete = '▋'
--   vim.g.signify_sign_delete_first_line = '▘'
--   vim.g.signify_sign_show_count = 0
-- end
function config.scrollbar()
  if vim.wo.diff then
    return
  end
  local w = vim.api.nvim_call_function('winwidth', {0})
  if w < 70 then
    return
  end
  local vimcmd = vim.api.nvim_command
  vimcmd('augroup ' .. 'ScrollbarInit')
  vimcmd('autocmd!')
  vimcmd("autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()")
  vimcmd("autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()")
  vimcmd("autocmd WinLeave,FocusLost,BufLeave    * silent! lua require('scrollbar').clear()")
  vimcmd('augroup end')
  vimcmd('highlight link Scrollbar Comment')
  vim.g.sb_default_behavior="never"
  vim.g.sb_bar_style = "solid"
end

function config.interestingwords()
  vim.g.interestingWordsDefaultMappingsK=0
  vim.g.interestingWordsDefaultMappingsN=0
  vim.g.interestingWordsRandomiseColors = 1
  vim.cmd("nnoremap <silent> <leader>u :call InterestingWords('n')<cr>")
  vim.cmd("vnoremap <silent> <leader>u :call InterestingWords('v')<cr>")
  vim.cmd("nnoremap <silent> <leader>U :call UncolorAllWords()<cr>")
  vim.cmd("nnoremap <silent> m :call WordNavigation('forward')<cr>")
  vim.cmd("nnoremap <silent> M :call WordNavigation('backward')<cr>")
  vim.g.interestingWordsCycleColors = 1
  vim.cmd([[let s:interestingWordsGUIColors = ['#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b', '#F92772', '#A6E22D', '#66d9ef','#E6DB74', '#FD9720', '#ae81ff', '#e73c50', '#ff0000', '#5f0000']])
end

function config.indentline()
  -- body
  vim.g.indentLine_color_gui = '#34453E'
  vim.g.indentLine_color_dark = 1 -- (default: 2)
  vim.g.indentLine_char_list = {'|', '¦', '┆', '┊', ''}
  vim.g.indentLine_enabled = 1
end
function config.theme()
  vim.cmd('colorscheme aurora')
  vim.cmd('hi Normal guibg=NONE ctermbg=NONE') -- remove background
  vim.cmd('hi EndOfBuffer guibg=NONE ctermbg=NONE') -- remove background
  vim.cmd('set cursorcolumn')
  vim.cmd('augroup vimrc_todo')
  vim.cmd('au!')
  vim.cmd("au Syntax * syn match MyTodo /\v<(FIXME|Fixme|NOTE|Note|TODO|ToDo|OPTIMIZE|XXX):/ containedin=.*Comment,vimCommentTitle")
  vim.cmd('augroup END')
  vim.cmd('hi def link MyTodo Todo')
end
function config.minimap()
  vim.cmd([[nmap <F14> :MinimapToggle<CR>]])
  local w = vim.api.nvim_call_function('winwidth', {0})
  if w > 180 then
    vim.g.minimap_width = 12
  elseif w > 120 then
    vim.g.minimap_width = 10
  elseif w > 80 then
    vim.g.minimap_width = 7
  else
    vim.g.minimap_width = 2
  end
end
return config
