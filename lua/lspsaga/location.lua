local M = {}

local lsp = vim.lsp
local lsp_util = require('vim.lsp.util')

local vfn = vim.fn
local validate = vim.validate

--@private
--- Returns nil if {status} is false or nil, otherwise returns the rest of the
--- arguments.
local function ok_or_nil(status, ...)
  if not status then return end
  return ...
end

--@private
--- Swallows errors.
---
--@param fn Function to run
--@param ... Function arguments
--@returns Result of `fn(...)` if there are no errors, otherwise nil.
--- Returns nil if errors occur during {fn}, otherwise returns
-- https://github.com/neg-serg/dotfiles/blob/master/nvim/.config/nvim/lua/vim/lsp/buf.lua
local function npcall(fn, ...)
  return ok_or_nil(pcall(fn, ...))
end

--@private
--- Sends an async request to all active clients attached to the current
--- buffer.
---
--@param method (string) LSP method name
--@param params (optional, table) Parameters to send to the server
--@param callback (optional, functionnil) Handler
--  `function(err, method, params, client_id)` for this request. Defaults
--  to the client callback in `client.callbacks`. See |lsp-callbacks|.
--
--@returns 2-tuple:
---  - Map of client-id:request-id pairs for all successful requests.
---  - Function which can be used to cancel all the requests. You could instead
---    iterate all clients and call their `cancel_request()` methods.
---
--@see |vim.lsp.buf_request()|
local function request(method, params, callback)
  validate {
    method = {method, 's'};
    callback = {callback, 'f', true};
  }
  return vim.lsp.buf_request(0, method, params, callback)
end

--- Checks whether the language servers attached to the current buffer are
--- ready.
---
--@returns `true` if server responds.
function M.server_ready()
  return not not vim.lsp.buf_notify(0, "window/progress", {})
end

local peek_location_callback = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    return
  end
  lsp_util.preview_location(result[1])
end


local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    -- vim.lsp.log.info(method, 'No location found')
    print(method, 'No location found')
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

--- Lists all the items that are called by the symbol under the
--- cursor in the |quickfix| window. If the symbol can resolve to
--- multiple items, the user can pick one in the |inputlist|.
function M.outgoing_calls()
  local params = util.make_position_params()
  request('textDocument/prepareCallHierarchy', params, function(_, _, result)
    local call_hierarchy_item = pick_call_hierarchy_item(result)
    vim.lsp.buf_request(0, 'callHierarchy/outgoingCalls', { item = call_hierarchy_item })
  end)
end

--- Lists all symbols in the current workspace in the quickfix window.
---
--- The list is filtered against {query}; if the argument is omitted from the
--- call, the user is prompted to enter a string on the command line. An empty
--- string means no filtering is done.
---
--@param query (string, optional)
function M.work_space_symbol(query)
  query = query or npcall(vfn.input, "Query: ", vfn.expand('<cword>'))
  local params = {query = query}
  request('workspace/symbol', params)
end

function M.preview_definition()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

function M.preview_declaration()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

function M.preview_implementation()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/implementation', params, preview_location_callback)
end

function M.preview_type_definition()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

-- function M.peek_definition()
--   local params = vim.lsp.util.make_position_params()
--   return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
-- end

-- Taken from https://www.reddit.com/r/neovim/comments/gyb077/nvimlsp_peek_defination_javascript_ttserver/
function preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 10
  before_context = before_context or 5
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end
  local range = location.targetRange or location.range
  local contents =
    vim.api.nvim_buf_get_lines(bufnr, range.start.line - before_context, range["end"].line + 1 + context, false)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return vim.lsp.util.open_floating_preview(contents, filetype)
end

function preview_location_callback(_, method, result)
  local context = 10
  if result == nil or vim.tbl_isempty(result) then
    print("No location found: " .. method)
    return nil
  end
  if vim.tbl_islist(result) then
    floating_buf, floating_win = preview_location(result[1], context)
  else
    floating_buf, floating_win = preview_location(result, context)
  end
end

function M.peek_definition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), floating_win) then
    vim.api.nvim_set_current_win(floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
  end
end


vim.api.nvim_set_keymap('n', '<leader>df',
                        '<cmd>lua require("lsp.location").peek_definition()<CR>',
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>di',
                        '<cmd>lua require("lsp.location").preview_implementation()<CR>',
                        { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ww',
                        '<cmd>lua require("lsp.location").work_space_symbol()<CR>',
                        { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gh',
                        '<cmd>lua require("lsp.provider").lsp_peek_references()<CR>',
                        { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ce',
                        '<cmd>lua require("lsp.diagnostic").show_buf_diagnostics()<CR><CR>',
                        { noremap = true, silent = true })

return M