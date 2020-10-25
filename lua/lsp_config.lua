local nvim_lsp = require('nvim_lsp')
local diagnostic = require('diagnostic')
local completion = require('completion')
local lsp_status = require('lsp-status')
local util = require('nvim_lsp/util')
local configs = require('nvim_lsp/configs')
local status = require('lsp.status')
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

  vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
  vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
  vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
  vim.lsp.callbacks['window/showMessage'] = function(...) print('') end  --- supress showMessage when I enable -tags=integration
  
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
  -- location may be LocationLink or Location (more luseful for the former)
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

-- print("lsp_config is loading return")

return M