local M = {}

local lsp = vim.lsp
local lsp_util = require('vim.lsp.util')

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
                        '<cmd>lua require("lsp_location").peek_definition()<CR>',
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>di',
                        '<cmd>lua require("lsp_location").preview_implementation()<CR>',
                        { noremap = true, silent = true })


return M