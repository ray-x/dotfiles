--local dir_bg = bg
-- local dir_fg = white_fg
-- local dir_gui = 'bold'
-- api.nvim_command('hi Directory guibg='..dir_bg..' guifg='..dir_fg..' gui='..dir_gui)
-- api.nvim_command('hi DirSeparator guifg='..dir_bg)
-- nvim_get_option() get global option nvim_buf_get_option() get current buffer option

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
  local exclude = Set { "LuaTree", "vista", "vista_kind", "floatterm", "defx"}
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if exclude[ft] then
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
  local lspstatus = require('lsp-status')
  if not should_show() then
    return {extensions.mode}
  end
  return {
      extensions.mode,
      sections.split,
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
      builtin.tail_file,
      sections.collapse_builtin {
        ' ',
        builtin.modified_flag
      },
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
      sections.highlight('ELFileIcon',  ' '),
      subscribe.buf_autocmd(
        "el_lsp_status_segment",
        "CursorHold,CursorHoldI",
        function(window, buffer)
          if winwidth() < 80 then return '' end
          return sections.highlight('ELFunc', lsp_statusline.segment(window, buffer))()
        end
      ),
      ' [', builtin.line, ' : ',  builtin.column, ']',
      sections.collapse_builtin{
        '[', builtin.help_list, builtin.readonly_list, ']',
      },
      sections.highlight('ELGitIcon', extensions.git_icon),
      subscribe.buf_autocmd(
        "el_git_status",
        "BufWritePost",
        function(window, buffer)
          return  extensions.git_changes(window, buffer)
        end
      ),
      ' ',
      subscribe.buf_autocmd(
        "el_git_branch",
        "BufRead",
        function(window, buffer)
          if winwidth() < 80 then return '' end
          local branch = extensions.git_branch(window, buffer)
          if branch == nil then
            return ''
          else
            return sections.highlight('ELGit',  branch)()
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
      builtin.filetype,
      builtin.number_of_lines,
    }

end



-- And then when you're all done, just call
require('el').setup { generator = generator }
local st = require('lsp-status.statusline')


