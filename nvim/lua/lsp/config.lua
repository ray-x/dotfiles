
local lsp = require("vim.lsp")

vim.cmd [[packadd lspsaga.nvim]]
local saga = require "lspsaga"
saga.init_lsp_saga()
M={}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function M.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function M.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd("command! -nargs=0 LspLog call v:lua.open_lsp_log()")
vim.cmd("command! -nargs=0 LspRestart call v:lua.reload_lsp()")

print("loading lsp client")
local cfg = {}
require('lsp.clients').setup(cfg)
require('lsp.mappings').setup(cfg)
return M
