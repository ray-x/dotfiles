local global = require'global'
local window = require 'lspsaga.window'
local vim,api,lsp = vim,vim.api,vim.lsp
local short_link = {}
local root_dir = vim.lsp.buf_get_clients()[1].config.root_dir
local M = {}

local contents = {}
local target_line_count = 0
local definition_uri = 0
local reference_uri = 0

local function apply_float_map(contents_bufnr)
  api.nvim_buf_set_keymap(contents_bufnr,'n',"o",":lua require'lsp.provider'.open_link(1)<CR>",{noremap = true,silent = true})
  api.nvim_buf_set_keymap(contents_bufnr,'n',"s",":lua require'lsp.provider'.open_link(2)<CR>",{noremap = true,silent = true})
  api.nvim_buf_set_keymap(contents_bufnr,'n',"i",":lua require'lsp.provider'.open_link(3)<CR>",{noremap = true,silent = true})
  api.nvim_buf_set_keymap(contents_bufnr,'n',"<TAB>",":lua require'lsp.provider'.insert_preview()<CR>",{noremap = true,silent = true})
  api.nvim_buf_set_keymap(contents_bufnr,'n',"q",":lua require'lsp.provider'.quit_float_window()<CR>",{noremap = true,silent = true})
end

local function defintion_reference(result,method_type)
  if vim.tbl_islist(result) then
    local method_option = {
      {icon = vim.g.lsp_nvim_defintion_icon or '   ',title = ':  '.. #result ..' Definitions'};
      {icon = vim.g.lsp_nvim_references_icon or '   ',title = ':  '.. #result ..' References',};
    }
    local params = vim.fn.expand("<cword>")
    local title = method_option[method_type].icon.. params ..method_option[method_type].title
    if method_type == 1 then
      table.insert(contents,title)
      target_line_count = 2
    else
      target_line_count = target_line_count + 3
      table.insert(contents," ")
      table.insert(contents,title)
    end

    if method_type == 1 then
      definition_uri = #result
    else
      reference_uri  = #result
    end

    for index,_ in ipairs(result) do
      local uri = result[index].targetUri or result[index].uri
      if uri == nil then
          return
      end
      local bufnr = vim.uri_to_bufnr(uri)
      if not api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
      end
      local link = vim.uri_to_fname(uri)
      local short_name = vim.fn.substitute(link,root_dir..'/','','')
      local target_line = '['..index..']'..' '..short_name
      local range = result[index].targetRange or result[index].range
      if index == 1  then
        table.insert(contents,' ')
      end
      table.insert(contents,target_line)
      target_line_count = target_line_count + index
      local lines = api.nvim_buf_get_lines(bufnr,range.start.line-0,range["end"].line+1+5,false)
      short_link[target_line_count] = {link=link,preview=lines,row=range.start.line+1,col=range.start.character+1}
      short_link[target_line_count].preview_data = {}
      short_link[target_line_count].preview_data.status = 0
    end
    if method_type == 2 then
      for _ =1,10,1 do
        table.insert(contents,' ')
      end
      local help = {
        "  Help: ",
        " ",
        "[TAB] : Preview     [o] : Open File     [s] : Vsplit";
        "[i]   : Split       [q] : Exit";
      }
      for _,v in ipairs(help) do
        table.insert(contents,v)
      end

      local opts = {
        relative = "cursor",
        style = "minimal",
      }
      M.contents_buf,M.contents_win,M.border_bufnr,M.border_win = window.create_float_window(contents,'plaintext',2,true,true,opts)
      api.nvim_win_set_cursor(M.contens_buf,{3,1})

      api.nvim_buf_add_highlight(M.contents_buf,-1,"DefinitionIcon",0,1,#method_option[method_type].icon-1)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"TargetWord",0,#method_option[method_type].icon,#params+#method_option[method_type].icon+1)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"DefinitionCount",0,0,-1)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"TargetWord",3+definition_uri,#method_option[method_type].icon,#params+#method_option[method_type].icon+1)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"ReferencesIcon",3+definition_uri,1,#method_option[method_type].icon+4)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"ReferencesCount",3+definition_uri,0,-1)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"HelpTitle",definition_uri+reference_uri+15,0,-1)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"HelpItem",definition_uri+reference_uri+17,0,-1)
      api.nvim_buf_add_highlight(M.contents_buf,-1,"HelpItem",definition_uri+reference_uri+18,0,-1)

      for i=1,definition_uri,1 do
        api.nvim_buf_add_highlight(M.contents_buf,-1,"TargetFileName",1+i,0,-1)
      end

      for i=1,reference_uri,1 do
        api.nvim_buf_add_highlight(M.contents_buf,-1,"TargetFileName",i+definition_uri+4,0,-1)
      end
      -- load float window map
      apply_float_map(M.contents_buf)
      -- clear contents
      contents = {}
      target_line_count = 0
      definition_uri = 0
      reference_uri = 0
    end
  end
end

-- action 1 mean enter
-- action 2 mean vsplit
-- action 3 mean split
function M.open_link(action_type)
  local action = {"edit ","vsplit ","split "}
  local current_line = vim.fn.line('.')
  print(current_line)
  if short_link[current_line] ~= nil then
    api.nvim_win_close(M.contents_win,true)
    api.nvim_win_close(M.border_win,true)
    api.nvim_command(action[action_type]..short_link[current_line].link)
    vim.fn.cursor(short_link[current_line].row,short_link[current_line].col)
  else
    return
  end
end

function M.insert_preview()
  local current_line = vim.fn.line('.')
  if short_link[current_line] ~= nil and short_link[current_line].preview_data.status ~= 1  then
    short_link[current_line].preview_data.status = 1
    short_link[current_line].preview_data.stridx = current_line
    short_link[current_line].preview_data.endidx = current_line + #short_link[current_line].preview
    local code_preview = vim.lsp.util._trim_and_pad(short_link[current_line].preview)
    vim.fn.append(current_line,code_preview)
  elseif short_link[current_line] ~= nil and short_link[current_line].preview_data.status == 1 then
    local stridx = short_link[current_line].preview_data.stridx
    local endidx = short_link[current_line].preview_data.endidx
    api.nvim_buf_set_lines(M.contents_buf,stridx,endidx,true,{})
    short_link[current_line].preview_data.status = 0
    short_link[current_line].preview_data.stridx = 0
    short_link[current_line].preview_data.endidx = 0
  elseif short_link[current_line] == nil then
    return
  end
end

function M.quit_float_window()
  if M.contents_buf ~= nil and M.contents_win ~= nil and M.border_win ~= nil then
    api.nvim_win_close(M.contents_win,true)
    api.nvim_win_close(M.border_win,true)
  else
    return
  end
end

function M.lsp_peek_references(timeout)
  local method = {"textDocument/definition","textDocument/references"}
  local params = lsp.util.make_position_params()
  local results = {}
  local response_a = lsp.buf_request_sync(0, method[1], params, timeout or 1000)
  local response_b = lsp.buf_request_sync(0, method[2], params, timeout or 1000)
  if not vim.tbl_isempty(response_a) then
    table.insert(results,response_a)
  end
  if not vim.tbl_isempty(response_b) then
    table.insert(results,response_b)
  end
  for i,v in ipairs(results) do
    if v[1].result == nil or vim.tbl_isempty(v[1].result) then
      print("No Location found:",method[i])
      -- if no References we doesn't popup window so need clean contents
      contents = {}
      return
    end
    defintion_reference(v[1].result,i)
  end
  return
end

-- jump to definition in split window
function M.lsp_jump_definition()
  local winr = vim.fn.winnr("$")
  local winsize = vim.api.nvim_exec([[
  echo (winwidth(0) - (max([len(line('$')), &numberwidth-1]) + 1)) < 110
  ]],true)
  if winr >= 4 or winsize == 1 then
    vim.lsp.buf.definition()
  else
    vim.api.nvim_command("vsplit")
    vim.lsp.buf.definition()
  end
end

-- Synchronously organise (Go) imports. Taken from
-- https://github.com/neovim/nvim-lsp/issues/115#issuecomment-654427197.
function M.go_organize_imports_sync(timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/callbacks.lua) for how to do this properly.
  local result = lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

function M.preview_definiton(timeout_ms)
  local method = "textDocument/definition"
  local params = lsp.util.make_position_params()
  local result = vim.lsp.buf_request_sync(0,method,params,timeout_ms or 1000)
  if result == nil or vim.tbl_isempty(result) then
      print("No location found: " .. method)
      return nil
  end
  if vim.tbl_islist(result) and not vim.tbl_isempty(result[1]) then
    local uri = result[1].result[1].uri or {}
    if #uri == 0 then return end
    local bufnr = vim.uri_to_bufnr(uri)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
    end
    local range = result[1].result[1].targetRange or result[1].result[1].range
    local content =
        vim.api.nvim_buf_get_lines(bufnr, range.start.line, range["end"].line + 1 +
        10, false)
    content = vim.list_extend({"什 Definition Preview 什",""},content)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    local opts = {
      relative = "cursor",
      style = "minimal",
    }
    local contents_buf,contents_winid,_,border_winid = window.create_float_window(content,filetype,1,false,false,opts)
    vim.lsp.util.close_preview_autocmd({"CursorMoved", "CursorMovedI", "BufHidden", "BufLeave"},
                                        border_winid)
    vim.lsp.util.close_preview_autocmd({"CursorMoved", "CursorMovedI", "BufHidden", "BufLeave"},
                                        contents_winid)
    vim.api.nvim_buf_add_highlight(contents_buf,-1,"DefinitionPreviewTitle",0,0,-1)
  end
end


-- TODO: codeAction
function M.code_action(timeout_ms)
  local method = "textDocument/codeAction"
  local params = lsp.util.make_position_params()
  local response = vim.lsp.buf_request_sync(0,method,params,timeout_ms or 1000)
  if vim.tbl_isempty(response) then
    print("No code actions available")
    return
  end
  local data = {'Code Action:'}
  for _,action in ipairs(response[1].result) do
    local title = action.title:gsub('\r\n', '\\r\\n')
    title = title:gsub('\n','\\n')
    table.insert(data,title)
  end
  window.create_float_window(data,'plaintext',1,true,false)
end

return M
