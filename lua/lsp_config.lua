local nvim_lsp = require('nvim_lsp')
local diagnostic = require('diagnostic')
local completion = require('completion')
local lsp_status = require('lsp-status')
local util = require('nvim_lsp/util')
local configs = require('nvim_lsp/configs')
local status = require('lspsaga.status')
vim.lsp.set_log_level("info")

-- print("lsp_config is loading")

lsp_status.register_progress()

lsp_status.config {
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end
}

local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    vim.lsp.log.info(method, 'No location found')
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

-- Synchronously organise (Go) imports.
function go_organize_imports_sync(timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result then return end
  result = result[1].result
  if not result then return end
  edit = result[1].edit
  vim.lsp.util.apply_workspace_edit(edit)
end

function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local on_attach = function(client, bufnr)
  diagnostic.on_attach(client, bufnr)

  lsp_status.on_attach(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  -- mapping.lua
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)  
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  

  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>de', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', ':PrevDiagnostic<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', ':NextDiagnostic<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[D', ':PrevDiagnosticCycle<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']D', ':NextDiagnosticCycle<CR>', opts)

  -- hook to nvim-lsputils
  vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler

  vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
  vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  -- us telescope for following binding
  vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
  vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
  
  vim.lsp.callbacks['window/showMessage'] = function(...) print('') end  --- supress showMessage when I enable -tags=integration
  
  -- vim.lsp.callbacks['textDocument/references'] = require'telescope.builtin'.lsp_references
  -- vim.lsp.callbacks['textDocument/documentSymbol'] = require'telescope.builtin'.lsp_workspace_symbols
  vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
  



  -- use with care. some project does not like the idea of auto-format, esp c/c++, js....
  vim.api.nvim_command ([[autocmd FileType python,javascript,typescript,lua,vim autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
  vim.api.nvim_command ([[autocmd FileType go autocmd BufWritePre <buffer> lua go_organize_imports_sync(1000)]])
    
  local file_types = "c,cpp,go,python,vim,sh,javascript,html,css,c,cpp,typescript"
  vim.api.nvim_command [[augroup nvim_lsp_autos]]
  vim.api.nvim_command [[autocmd!]]
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    
    --[[ mappings that are shared across all supported langs ]]--
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gd        <cmd>lua vim.lsp.buf.declaration()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gt       <cmd>lua vim.lsp.buf.type_definition()<CR>]])

  vim.api.nvim_command([[augroup END]])
  local method = "textDocument/publishDiagnostics"
  local default_callback = vim.lsp.callbacks[method]
  vim.lsp.callbacks[method] = function(err, method, result, client_id)
    default_callback(err, method, result, client_id)
    if result and result.diagnostics then
        local item_list = {}
        for _, v in ipairs(result.diagnostics) do
            local fname = result.uri
            table.insert(item_list, { filename = fname, lnum = v.range.start.line + 1, col = v.range.start.character + 1; text = v.message; })
            print(v.message)
        end
        local old_items = vim.fn.getqflist()
        for _, old_item in ipairs(old_items) do
            local bufnr = vim.uri_to_bufnr(result.uri)
            if vim.uri_from_bufnr(old_item.bufnr) ~= result.uri
                then
                    table.insert(item_list, old_item)
                end
            end
            vim.fn.setqflist({}, ' ', { title = 'LSP'; items = item_list; })
        end
    end

end

local servers = { 'gopls', 'tsserver', 'bashls', 'pyls', 'sumneko_lua', 'vimls', 'html', 'jsonls', 'cssls', 'yamlls', 'ccls', 'dockerls' }
for _, lsp in ipairs(servers) do
  lsp_status.register_progress()
  lsp_status.config({
    status_symbol = '',
    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = 'כֿ',
    indicator_hint = 'λ',
    indicator_ok = '✔️', 
    spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
  })
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end


--[[ Go ]]--
nvim_lsp.gopls.setup {
    on_attach=on_attach,
    capabilities = lsp_status.capabilities,
    cmd = {
        "gopls",

        -- share the gopls instance if there is one already
        "-remote=auto",

        --[[ debug options ]]--
        --"-logfile=auto",
        --"-debug=:0",
        --"-remote.debug=:0",
        --"-rpc.trace",
    },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          unreachable = false,
        },
        codelens = {
          generate = true, -- Don't show the `go generate` lens.
          gc_details = true, --  // Show a code lens toggling the display of gc's choices.

        },
        usePlaceholders    = true,
        completeUnimported = true,
        staticcheck = true,
        matcher            = "fuzzy",
        symbolMatcher      = "fuzzy",
        -- buildFlags = {"-tags", "integration"}
        -- buildFlags = {"-tags", "functional"}
      },
    }
    ,
    root_dir = function(fname)
      return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
    end;
}



-- populate quickfix list with diagnostics
local method = "textDocument/publishDiagnostics"
local default_callback = vim.lsp.callbacks[method]
vim.lsp.callbacks[method] = function(err, method, result, client_id)
    default_callback(err, method, result, client_id)
    if result and result.diagnostics then
        local item_list = {}
        for _, v in ipairs(result.diagnostics) do
            local fname = result.uri
            table.insert(item_list, { filename = fname, lnum = v.range.start.line + 1, col = v.range.start.character + 1; text = v.message; })
            print(v.message)
        end
        local old_items = vim.fn.getqflist()
        for _, old_item in ipairs(old_items) do
            local bufnr = vim.uri_to_bufnr(result.uri)
            if vim.uri_from_bufnr(old_item.bufnr) ~= result.uri
                then
                    table.insert(item_list, old_item)
                end
            end
            vim.fn.setqflist({}, ' ', { title = 'LSP'; items = item_list; })
        end
    end




nvim_lsp.sumneko_lua.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  settings = {
    Lua = {
      diagnostics = {
          globals = {"vim", "vis", "rpm"},
          disable = {"lowercase-global"}
      },
      runtime = {
        version = "LuaJIT"
      }
    }
  }
}


-- Some arbitrary servers
nvim_lsp.clangd.setup({
  callbacks = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true
  },
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
})

nvim_lsp.pyls_ms.setup({
  callbacks = lsp_status.extensions.pyls_ms.setup(),
  settings = { python = { workspaceSymbols = { enabled = true }}},
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
})

-- nvim_lsp.gopls.setup({
--   callbacks = lsp_status.extensions.gopls.setup(),
--   settings = { python = { workspaceSymbols = { enabled = true }}},
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities
-- })

-- nvim_lsp.tsserver.setup({
--   callbacks = lsp_status.extensions.tsserver.setup(),
--   settings = { python = { workspaceSymbols = { enabled = true }}},
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities
-- })



nvim_lsp.ghcide.setup({
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
})
nvim_lsp.rust_analyzer.setup({
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
})



return {}