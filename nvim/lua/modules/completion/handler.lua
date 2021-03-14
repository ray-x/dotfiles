local api = vim.api
local lspconfig = require "lspconfig"
local global = require "core.global"
local lsp = require("vim.lsp")

if not packer_plugins["nvim-lua/lsp-status.nvim"] or not packer_plugins["lsp-status.nvim"].loaded then
  vim.cmd [[packadd lsp-status.nvim]]
end
local lsp_status = require("lsp-status")

local diagnostic_map = function(bufnr)
  local opts = {noremap = true, silent = true}
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]O", ":lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end
local M = {}
local diagnostic_list = {}
diagnostic_list[vim.bo.filetype] = {}
M.on_attach = function(client, bufnr)
  if lsp_status ~= nil then
    lsp_status.on_attach(client, bufnr)
  end
  require "lsp_signature".on_attach()
  diagnostic_map(bufnr)
  -- lspsaga
  require "utils.highlight".add_highlight()

  -- if client.resolved_capabilities.document_formatting then
  --   format.lsp_before_save()
  -- end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- https://github.com/fsouza
  vim.lsp.handlers["textDocument/documentHighlight"] = function(_, _, result, _)
    if not result then
      return
    end
    bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.util.buf_clear_references(bufnr)
    vim.lsp.util.buf_highlight_references(bufnr, result)
  end

  local diag_hdlr = function(err, method, result, client_id, br, config)
    -- vim.lsp.diagnostic.clear(vim.fn.bufnr(), client.id, nil, nil)
    vim.lsp.diagnostic.on_publish_diagnostics(err, method, result, client_id, br, config)
    local ft = vim.bo.filetype
    if result and result.diagnostics then
      local item_list = {}
      local s = result.uri
      local fname = s
      for _, v in ipairs(result.diagnostics) do
        i, j = string.find(s, "file://")
        if j then
          fname = string.sub(s, j + 1)
        end
        table.insert(
          item_list,
          {filename = fname, lnum = v.range.start.line + 1, col = v.range.start.character + 1, text = v.message}
        )
      end
      -- local old_items = vim.fn.getqflist()
      local old_items = diagnostic_list[ft] == nil and {} or diagnostic_list[ft]
      for _, old_item in ipairs(old_items) do
        bufnr = bufnr or vim.uri_to_bufnr(result.uri)
        if vim.uri_from_bufnr(old_item.bufnr) ~= result.uri then
          table.insert(item_list, old_item)
        end
      end
      diagnostic_list[ft] = item_list
    --- vim.fn.setqflist({}, " ", {title = "LSP", items = item_list})
    end
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    diag_hdlr,
    {
      -- Enable underline, use default values
      underline = true,
      -- Enable virtual text, override spacing to 0
      virtual_text = {
        spacing = 0,
        prefix = "" --'',  
      },
      -- Use a function to dynamically turn signs off
      -- and on, using buffer local variables
      signs = true,
      -- Disable a feature
      update_in_insert = false
    }
  )

  vim.lsp.handlers["textDocument/hover"] = function(_, method, result)
    vim.lsp.util.focusable_float(
      method,
      function()
        if not (result and result.contents) then
          return
        end
        local markdown_lines = lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
          return
        end

        local bnr, contents_winid, _, border_winid = vim.lsp.util.fancy_floating_markdown(markdown_lines)
        lsp.util.close_preview_autocmd({"CursorMoved", "BufHidden", "InsertCharPre"}, contents_winid)
        lsp.util.close_preview_autocmd({"CursorMoved", "BufHidden", "InsertCharPre"}, border_winid)
        return bnr, contents_winid
      end
    )
  end

  vim.cmd [[packadd vim-illuminate]]
  require "illuminate".on_attach(client)
  require "utils.lspkind".init()

  require "utils.lspkind".init()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

M.show_diagnostic = function()
  if diagnostic_list[vim.bo.filetype] ~= nil then
    vim.fn.setqflist({}, " ", {title = "LSP", items = diagnostic_list[vim.bo.filetype]})
  end
end

M.setup = function(cfg)
end
return M
