local api = vim.api
local lspconfig = require "lspconfig"
local global = require "core.global"
--local format = require('modules.completion.format')

local lsp = require("vim.lsp")

vim.cmd [[packadd lspsaga.nvim]]
local saga = require "lspsaga"
saga.init_lsp_saga()
M={}

if not packer_plugins["nvim-lua/lsp-status.nvim"] or not packer_plugins["lsp-status.nvim"].loaded then
  vim.cmd [[packadd lsp-status.nvim]]
end
local lsp_status = require("lsp-status")

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
require('modules.completion.clients').setup(cfg)
require('modules.completion.mappings').setup(cfg)
return M
