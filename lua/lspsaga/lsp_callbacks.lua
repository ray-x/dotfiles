local vim,api,lsp = vim,vim.api,vim.lsp
local window = require('lspsaga.window')
local callbacks = {}

local function lookup_section(settings, section)
  for part in vim.gsplit(section, '.', true) do
    settings = settings[part]
    if not settings then
      return
    end
  end
  return settings
end

-- lsp sign
local function lsp_diagnostic_sign()
  vim.fn.sign_define('LspDiagnosticsErrorSign', {text='', texthl='LspDiagnosticsError',linehl='', numhl=''})
  vim.fn.sign_define('LspDiagnosticsWarningSign', {text='', texthl='LspDiagnosticsWarning', linehl='', numhl=''})
  vim.fn.sign_define('LspDiagnosticsInformationSign', {text='', texthl='LspDiagnosticsInformation', linehl='', numhl=''})
  vim.fn.sign_define('LspDiagnosticsHintSign', {text='', texthl='LspDiagnosticsHint', linehl='', numhl=''})
end

-- Add I custom callbacks function in lsp server config
function callbacks.add_callbacks(server_setup)

  server_setup.callbacks["window/logMessage"] = function(err, method, params, client_id)
        if params and params.type <= server_setup.log_level then
          assert(vim.lsp.callbacks["window/logMessage"], "Callback for window/logMessage notification is not defined")
          vim.lsp.callbacks["window/logMessage"](err, method, params, client_id)
        end
      end

  server_setup.callbacks["window/showMessage"] = function(err, method, params, client_id)
    if params and params.type <= server_setup.message_level then
      assert(vim.lsp.callbacks["window/showMessage"], "Callback for window/showMessage notification is not defined")
      vim.lsp.callbacks["window/showMessage"](err, method, params, client_id)
    end
  end

  -- add workspace/configuration callback function
  server_setup.callbacks["workspace/configuration"] = function(err, _, params, _)
      if err then error(tostring(err)) end
      if not params.items then
        return {}
      end

      local result = {}
      for _, item in ipairs(params.items) do
        if item.section then
          local value = lookup_section(server_setup.settings, item.section) or vim.NIL
          -- For empty sections with no explicit '' key, return settings as is
          if value == vim.NIL and item.section == '' then
            value = server_setup.settings or vim.NIL
          end
          table.insert(result, value)
        end
      end
      return result
    end

  -- diagnostic callbacks
  server_setup.callbacks['textDocument/publishDiagnostics'] = function(_, _, result)
    if not result then return end
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)
    if not bufnr then
      vim.api.nvim_out_write(string.format("LSP.publishDiagnostics: Couldn't find buffer for %s", uri))
      return
    end
    lsp.util.buf_clear_diagnostics(bufnr)

    local sign_ns = 'vim_lsp_signs'
    local protocol = require 'vim.lsp.protocol'
    lsp_diagnostic_sign()

    local diagnostic_severity_map = {
      [protocol.DiagnosticSeverity.Error] = "LspDiagnosticsErrorSign";
      [protocol.DiagnosticSeverity.Warning] = "LspDiagnosticsWarningSign";
      [protocol.DiagnosticSeverity.Information] = "LspDiagnosticsInformationSign";
      [protocol.DiagnosticSeverity.Hint] = "LspDiagnosticsHintSign";
    }
    -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#diagnostic
    -- The diagnostic's severity. Can be omitted. If omitted it is up to the
    -- client to interpret diagnostics as error, warning, info or hint.
    -- TODO: Replace this with server-specific heuristics to infer severity.
    for _, diagnostic in ipairs(result.diagnostics) do
      if diagnostic.severity == nil then
        diagnostic.severity = vim.lsp.protocol.DiagnosticSeverity.Error
      end
      vim.fn.sign_place(0, sign_ns, diagnostic_severity_map[diagnostic.severity], bufnr, {lnum=(diagnostic.range.start.line+1),priority=90})
    end

    lsp.util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
    lsp.util.buf_diagnostics_underline(bufnr, result.diagnostics)
    if vim.g.diagnostic_enable_virtual_text == 1 then
      -- use virtual text show message diagnostic
      lsp.util.buf_diagnostics_virtual_text(bufnr, result.diagnostics)
    end
    -- lsp.util.buf_diagnostics_signs(bufnr, result.diagnostics)
    api.nvim_command("doautocmd User LspDiagnosticsChanged")
  end

  server_setup.callbacks['textDocument/hover'] = function(_, method, result)
    vim.lsp.util.focusable_float(method, function()
        if not (result and result.contents) then return end
        local markdown_lines = lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then return end

        local bufnr,contents_winid,_,border_winid = window.fancy_floating_markdown(markdown_lines)
        lsp.util.close_preview_autocmd({"CursorMoved", "BufHidden", "InsertCharPre"}, contents_winid)
        lsp.util.close_preview_autocmd({"CursorMoved", "BufHidden", "InsertCharPre"}, border_winid)
        return bufnr,contents_winid
    end)
    end
end

return callbacks
