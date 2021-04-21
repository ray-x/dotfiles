
local lsp = require("vim.lsp")
--
-- vim.cmd [[packadd lspsaga.nvim]]
-- local saga = require "lspsaga"
-- saga.init_lsp_saga()

vim.cmd [[packadd navigator.lua]]
local navigator = require "navigator"
navigator.setup()
M={}
--
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- function M.reload_lsp()
--   vim.lsp.stop_client(vim.lsp.get_active_clients())
--   vim.cmd [[edit]]
-- end
--
-- function M.open_lsp_log()
--   local path = vim.lsp.get_log_path()
--   vim.cmd("edit " .. path)
-- end
--
-- vim.cmd("command! -nargs=0 LspLog call v:lua.open_lsp_log()")
-- vim.cmd("command! -nargs=0 LspRestart call v:lua.reload_lsp()")
--
-- print("loading lsp client")
-- local cfg = {}
-- require('lsp.clients').setup(cfg)
-- require('lsp.mappings').setup(cfg)
-- return M


local stylelint = {
  lintCommand = 'stylelint --stdin --stdin-filename ${INPUT} --formatter compact',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f: line %l, col %c, %tarning - %m',
    '%f: line %l, col %c, %trror - %m',
  },
  formatCommand = 'stylelint --fix --stdin --stdin-filename ${INPUT}',
  formatStdin = true,
}
require'lspconfig'.efm.setup {
  cmd = { 'efm-langserver' },
  init_options = {
    documentFormatting = true,
    rename = false,
    hover = false,
    completion = false,
  },
  filetypes = { 'typescript', 'typescriptreact' },
  settings = {
    rootMarkers = { '.git', 'package.json' },
    languages = {
      typescript = { stylelint },
      typescriptreact = { stylelint },
      lua = {
                {formatCommand = "lua-format -i", formatStdin = true}
      }
    },
  },
}

require'lspconfig'.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      -- see available options in stylelint-lsp documentation
    }
  }
}
