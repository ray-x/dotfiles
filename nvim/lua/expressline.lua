--local dir_bg = bg
-- local dir_fg = white_fg
-- local dir_gui = 'bold'
-- api.nvim_command('hi Directory guibg='..dir_bg..' guifg='..dir_fg..' gui='..dir_gui)
-- api.nvim_command('hi DirSeparator guifg='..dir_bg)
-- nvim_get_option() get global option nvim_buf_get_option() get current buffer option

--[[
let s:left_sep = ' ❯❯ '
let s:right_sep = ' ❮❮ '  
        let s:seperator.filenameright = ''
        let s:seperator.filesizeright = ''
        let s:seperator.gitleft = ''
        let s:seperator.gitright = ''
        let s:seperator.lineinfoleft = ''
        let s:seperator.lineformatright = ''
        let s:seperator.EndSeperate = ' '
        let s:seperator.emptySeperate1 = ''
    elseif a:style == 'slant-cons'
        let s:seperator.homemoderight = ''
        let s:seperator.filenameright = ''
        let s:seperator.filesizeright = '' let s:seperator.gitleft = ''
        let s:seperator.gitright = ''
        let s:seperator.lineinfoleft = ''
        let s:seperator.lineformatright = ''
        let s:seperator.EndSeperate = ' '
        let s:seperator.emptySeperate1 = ''
    elseif a:style == 'slant-fade'
        let s:seperator.homemoderight = ''
        let s:seperator.filenameright = ''
        let s:seperator.filesizeright = ''
        let s:seperator.gitleft = ''
        let s:seperator.gitright = ''
        " let s:seperator.gitright = ''
        let s:seperator.lineinfoleft = ''
        let s:seperator.lineformatright = ''
        let s:seperator.EndSeperate = ' '
        let s:seperator.emptySeperate1 = ''
--]]

function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t, cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end
function split_path(str)
   return split(str,'[\\/]+')
end

lstatus = function  (_, buffer)
  if not buffer.lsp or not has_lsp_status then
    return ''
  end

  local ok, result = pcall(lsp_status.status)
  if not ok then
    return ''
  end
  return string.format('%s', result)
end

local function git()
  local stl_text = ''
  if vim.fn.exists('g:loaded_fugitive') and vim.bo.modifiable then
    local git_head = vim.fn['fugitive#head']()
    stl_text = string.len(git_head) > 0 and '%#stlGit#[' .. git_head .. ']%*' or ''
  end
  return stl_text
end

local function diagnostics(level)
  if #vim.lsp.buf_get_clients() == 0 then
    return ''
  end

  local count = vim.lsp.diagnostic.get_count(0, level)
  print( 'diagnostics' .. count)
  if count ~= 0 then
    return ' '..count..' '
  else
    count = diagnostic_ale_error()
    if count ~= 0 then
      return ' '..count..' '
    end
  end

  return ' _ '
end

current_function = function(_, buffer)
  if not buffer.lsp or not has_lsp_status then
    return ''
  end

  local ok, current_func = pcall(get_current_function, _, buffer)
  if ok and current_func and #current_func > 0 then
    return string.format('[ %s ]', current_func)
  end

  return ''
end


function getEntryFromEnd(table, entry)
    local count = (table and #table or false)
    if (count) then
        return table[count-entry];
    end
    return false;
end

local Set = function(list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local winwidth = function ()
  -- body
  return vim.api.nvim_call_function('winwidth', {0})
end

local should_show = function()
  -- body
  local exclude = Set {"LuaTree", "vista", "vista_kind", "floatterm", "defx"}
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if exclude[ft] or winwidth() < 80 then
    return false
  end

  return true
end

local TrimmedDirectory = function(dir)
  local home = os.getenv("HOME")
  local _, index = string.find(dir, home, 1)
  if index ~= nil and index ~= string.len(dir) then
    -- TODO Trimmed Home Directory
    dir = string.gsub(dir, home, '~')
  end
  local pa=split_path(dir)
  local p1=getEntryFromEnd(pa, 0)
  local p2=getEntryFromEnd(pa, 1)
  local pc=''
  if p2~=nil then
    pc=p2 .. '/' .. p1 .. '/'
  elseif p2~=nil then
    pc=p1 .. '/'
  else
    pc=''
  end
  return(pc)
end

-- show current line percent of all lines
local function current_line_percent()
  local current_line = vim.fn.line('.')
  local total_line = vim.fn.line('$')
  if current_line == 1 then
    return ' Top '
  elseif current_line == vim.fn.line('$') then
    return ' Bot '
  end
  local result,_ = math.modf((current_line/total_line)*100)
  return ' '.. result .. '%% '
end

-- extension for scoll bar
function scrollbar_instance()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local default_chars = {'__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██'}
  local chars = default_chars
  local index = 1

  if  current_line == 1 then
    index = 1
  elseif current_line == total_lines then
    index = #chars
  else
    local line_no_fraction = vim.fn.floor(current_line) / vim.fn.floor(total_lines)
    index = vim.fn.float2nr(line_no_fraction * #chars)
    if index == 0 then
      index = 1
    end
  end
  percent = current_line_percent()
  return percent..' % '..chars[index]
end


local function diagnostic_ale_error()
  local buf_nr = vim.fn.bufnr()
  local counts = vim.fn['ale#statusline#Count'](buf_nr)
  local error_counts = counts.error + counts.style_error
  return error_counts
end


local generator = function()
  local el_segments = {}
  local builtin = require('el.builtin')
  local extensions = require('el.extensions')
  local log = require('el.log')
  local meta = require('el.meta')
  local processor = require('el.processor')
  local sections = require('el.sections')
  local subscribe = require('el.subscribe')

  local lsp_statusline = require('el.plugins.lsp_status')
  local extensions = require('el.extensions')
  set_highlight = function(name, fg, bg, gui)
    local cmd = "highlight! "..name
    cmd = cmd.." ".."gui="..gui.." ".."guifg="..fg.." ".."guibg="..bg
    vim.api.nvim_command(cmd)
  end
  set_highlight('ELNormal', '#addb67', '#4f425e', 'NONE')
  set_highlight('ELGit', '#fbed7b', '#3f324e','NONE')
  set_highlight('ELFileIcon', '#8dabf7', '#4f425e', 'NONE')
  set_highlight('ELGitIcon', '#fd4b47', '#4f425e', 'NONE')
  set_highlight('ELFunc', '#10abf7', '#4f425e', 'Bold')
  -- set_highlight('ELDirectory', '#10abf7', '#4f225e', 'NONE')
  if not should_show() then
    return {}
  end
  return {
      extensions.mode,
      sections.highlight('ELGitIcon', ' '),
      subscribe.buf_autocmd(
        "el_git_branch",
        "BufRead",
        function(window, buffer)
          if winwidth() < 80 then return '' end
          local branch = extensions.git_branch(window, buffer)
          if branch == nil then
            return ''
          else

            return sections.highlight('ELGit',  branch .. '')()
          end
        end
      ),
      subscribe.buf_autocmd(
        "el_file_icon",
        "BufRead",
        function(_, buffer)
          if winwidth() < 80 then return '' end
          return sections.highlight('ELFileIcon',  extensions.file_icon(_, buffer))()
        end
      ),
      subscribe.buf_autocmd(
        "el_folder",
        "BufEnter",
        function(window, buffer)
            if winwidth() < 100 then
              return ''
            end
            local dir = vim.api.nvim_call_function('getcwd', {})
            return  TrimmedDirectory(dir)
        end
      ),
      builtin.tail_file,'',
      sections.collapse_builtin {
        ' ',
        builtin.modified_flag
      },
      sections.split,
      sections.highlight('ELFileIcon',  ' '),
      -- sections.split,
      --  subscribe.buf_autocmd(
      --   "el_wc",
      --   "BufEnter,CursorMoved",
      --   function(window, buffer)
      --     if winwidth() < 70 then return '' end
      --     -- local mode = vim.api.nvim_call_function('mode', {})
      --     return vim.fn['WordCount']()
      --   end
      -- ),

      -- lsp_statusline.current_function,
      -- lsp_statusline.segment,
      -- lsp_statusline.server_progress,
      subscribe.buf_autocmd(
        "el_lsp_status",
        "BufWritePost,BufEnter,CursorHold",
        function(window, buffer)
          if winwidth() < 80 then return '' end
          -- return sections.highlight('ELFunc', lsp_statusline.segment(window, buffer))()
          return sections.highlight('ELFunc', require('lsp-status').status())()
        end
      ),
      builtin.tail_file,' ',
      -- sections.highlight('ELGit',  ' '),
      -- subscribe.buf_autocmd(
      --   "el_lsp_diagnostics",
      --   "BufWritePost, BufEnter",
      --   function(window, buffer)
      --     return sections.highlight('ELGit', diagnostics('Error'))()
      --   end
      -- ),
      -- sections.highlight('ELFileIcon',  ' '),
      -- subscribe.buf_autocmd(
      --   "el_lsp_diagnostics",
      --   "BufWritePost,BufEnter",
      --   function(window, buffer)
      --     return sections.highlight('ELGit', diagnostics('Warning'))()
      --   end
      -- ),
      sections.split,
      -- lsp_statusline.server_progress,

      sections.split,
      ' [', builtin.line, ':',  builtin.column, '] ',
      sections.collapse_builtin{
      ' [', builtin.help_list, builtin.readonly_list, '] ',
      },
      sections.highlight('ELFileIcon',  ' '),
      subscribe.buf_autocmd(
        "el_git_status",
        "BufWritePost",
        function(window, buffer)
          return  extensions.git_changes(window, buffer)
        end
      ),
      builtin.filetype,
      builtin.number_of_lines,
      subscribe.buf_autocmd(
        "el_scrol",
        "CursorMoved",
        function(_, buffer)
          if winwidth() < 50 then return '' end
          return sections.highlight('ELFileIcon', scrollbar_instance)()
        end
      ),
    }

end



-- And then when you're all done, just call
require('el').setup { generator = generator }



