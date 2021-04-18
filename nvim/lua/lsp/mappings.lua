local function set_keymap(...)
  vim.api.nvim_set_keymap(...)
end

local event_hdlrs = {
  {ev = "BufWritePre", func = "diagnostic.set_loclist({open_loclist = false})"},
  {ev = "CursorHold", func = "document_highlight()"},
  {ev = "CursorHoldI", func = "document_highlight()"},
  {ev = "CursorMoved", func = "clear_references()"}
}
local key_maps = {
  {key = "gr", func = "references()"},
  {mode = "i", key = "<M-k>", func = "signature_help()"},
  {key = "gs", func = "signature_help()"},
  {key = "g0", func = "document_symbol()"},
  {key = "gW", func = "workspace_symbol()"},
  {key = "<c-]>", func = "definition()"},
  {key = "de", func = "declaration()"},
  {key = "<Leader>re", func = "rename()"},
  {key = "<Leader>gi", func = "incoming_calls()"},
  {key = "<Leader>go", func = "outgoing_calls()"},
  {key = "gD", func = "implementation()"},
  {key = "gt", func = "type_definition()"},
  {key = "gL", func = "show_line_diagnostics()"},
  {key = "gG", func = "show_diagnostic"},
  {key = "gG", func = "show_diagnostic"},
  {key = "<C-LeftMouse>", func = "definition()"},
  {key = "g<LeftMouse>", func = "implementation()"}
}

local function set_mapping(user_opts)
  local opts = {noremap = true, silent = true}
  user_opts = user_opts or {}
  local user_key = user_opts.keymaps or {}
  for _, v in pairs(user_key) do
    local exists = false
    for _, default in pairs(key_maps) do
      if v.func == default.func then
        default.key, exists = v.key, true
        break
      end
    end
    if not exists then
      table.insert(key_maps, v)
    end
  end
  for _, value in pairs(key_maps) do
    local f = "<Cmd>lua vim.lsp.buf." .. value.func .. "<CR>"
    if value.func == "show_line_diagnostics" then
      f = "<Cmd>lua vim.lsp." .. value.func .. "<CR>"
    end
    local k = value.key
    local m = value.mode or "n"
    set_keymap(m, k, f, opts)
  end
end

local function set_event_handler(user_opts)
  user_opts = user_opts or {}
  local file_types = "c,cpp,h,go,python,vim,sh,javascript,html,css,lua,typescript"
  -- local format_files = "c,cpp,h,go,python,vim,javascript,typescript" --html,css,
  vim.api.nvim_command [[augroup nvim_lsp_autos]]
  vim.api.nvim_command [[autocmd!]]

  for _, value in pairs(event_hdlrs) do
    local f = ""
    if string.find(value.func, "diagnostic") then
      f = "lua vim.lsp." .. value.func
    else
      f = "lua vim.lsp.buf." .. value.func
    end
    local cmd = "autocmd FileType " .. file_types .. " autocmd nvim_lsp_autos " .. value.ev .. " <buffer> silent! " .. f
    vim.api.nvim_command(cmd)
  end
  vim.api.nvim_command([[augroup END]])
end

local M = {}

function M.setup(user_opts)
  set_mapping(user_opts)
  set_event_handler(user_opts)
  -- vim.lsp.handlers["textDocument/codeAction"] = require "codeagent.codeAction".code_action_handler
  vim.lsp.handlers["textDocument/references"] = require "navigator.locations".references_handler
  -- vim.lsp.handlers["textDocument/definition"] = require "codeagent.locations".definition_handler
  -- vim.lsp.handlers["textDocument/declaration"] = require "codeagent.locations".declaration_handler
  -- vim.lsp.handlers["textDocument/typeDefinition"] = require "codeagent.locations".typeDefinition_handler
  -- -- vim.lsp.handlers["textDocument/implementation"] = require "codeagent.locations".implementation_handler
  -- vim.lsp.handlers["textDocument/documentSymbol"] = require "codeagent.symbols".document_handler
  -- vim.lsp.handlers["workspace/symbol"] = require "codeagent.symbols".workspace_handler
end

return M
