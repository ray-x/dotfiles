local vim, fn, api, g = vim, vim.fn, vim.api, vim.g
local lsp = require("vim.lsp")
local fuzzy = require("fuzzy.lib")
local helpers = require("fuzzy.lib.helpers")
local source = require("fuzzy.lib.source")
local sorter = require("fuzzy.lib.sorter")
local drawer = require("fuzzy.lib.drawer")
local location = require("fuzzy.lib.location")

if not packer_plugins["nvim-lua/lsp-status.nvim"] or not packer_plugins["lsp-status.nvim"].loaded then
  vim.cmd [[packadd lsp-status.nvim]]
end
local lsp_status = require("lsp-status")
local P = require("utils.helper").P

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

M.setup = function(cfg)
end

local function perror(err)
  print("ERROR: " .. tostring(err))
end

local function check_capabilities(feature, client_id)
  local clients = vim.lsp.buf_get_clients(client_id or 0)

  local supported_client = false
  for _, client in pairs(clients) do
    supported_client = client.resolved_capabilities[feature]
    if supported_client then
      goto continue
    end
  end

  ::continue::
  if supported_client then
    return true
  else
    if #clients == 0 then
      print("LSP: no client attached")
    else
      print("LSP: server does not support " .. feature)
    end
    return false
  end
end
local function extract_result(results_lsp)
  if results_lsp then
    local results = {}
    for _, server_results in pairs(results_lsp) do
      if server_results.result then
        vim.list_extend(results, server_results.result)
      end
    end

    return results
  end
end

local function call_sync(method, params, opts, handler)
  params = params or {}
  opts = opts or {}
  local results_lsp, err = vim.lsp.buf_request_sync(0, method, params, opts.timeout or g.fzf_lsp_timeout)

  handler(err, method, extract_result(results_lsp), nil, nil)
end
local function lines_from_locations(locations, include_filename)
  local fnamemodify = (function(filename)
    if include_filename then
      return fn.fnamemodify(filename, ":~:.") .. ":"
    else
      return ""
    end
  end)

  local lines = {}
  for _, loc in ipairs(locations) do
    table.insert(
      lines,
      (fnamemodify(loc["filename"]) .. loc["lnum"] .. ":" .. loc["col"] .. ": " .. vim.trim(loc["text"]))
    )
  end

  return lines
end

local function location_handler(err, _, locations, _, bufnr, error_message)
  if err ~= nil then
    perror(err)
    return
  end

  if not locations or vim.tbl_isempty(locations) then
    print(error_message)
    return
  end

  if vim.tbl_islist(locations) then
    if #locations == 1 then
      vim.lsp.util.jump_to_location(locations[1])

      return
    end
  else
    vim.lsp.util.jump_to_location(locations)
  end

  return lines_from_locations(vim.lsp.util.locations_to_items(locations, bufnr), true)
end

local function call_hierarchy_handler(direction, err, _, result, _, _, error_message)
  if err ~= nil then
    perror(err)
    return
  end

  if not result or vim.tbl_isempty(result) then
    print(error_message)
    return
  end

  local items = {}
  for _, call_hierarchy_call in pairs(result) do
    local call_hierarchy_item = call_hierarchy_call[direction]
    for _, range in pairs(call_hierarchy_call.fromRanges) do
      table.insert(
        items,
        {
          filename = assert(vim.uri_to_fname(call_hierarchy_item.uri)),
          text = call_hierarchy_item.name,
          lnum = range.start.line + 1,
          col = range.start.character + 1
        }
      )
    end
  end

  return lines_from_locations(items, true)
end
local function partial(func, arg)
  return (function(...)
    return func(arg, ...)
  end)
end
local call_hierarchy_handler_from = partial(call_hierarchy_handler, "from")
local call_hierarchy_handler_to = partial(call_hierarchy_handler, "to")

function M.incoming_calls(bang, opts)
  if not check_capabilities("call_hierarchy") then
    return
  end

  local params = vim.lsp.util.make_position_params()
  call_sync("callHierarchy/incomingCalls", params, opts, partial(incoming_calls_handler, bang))
end

function M.outgoing_calls(bang, opts)
  if not check_capabilities("call_hierarchy") then
    return
  end

  local params = vim.lsp.util.make_position_params()
  call_sync("callHierarchy/outgoingCalls", params, opts, partial(outgoing_calls_handler, bang))
end

function M.implementation(bang, opts)
  if not check_capabilities("implementation") then
    return
  end

  local params = vim.lsp.util.make_position_params()
  call_sync("textDocument/implementation", params, opts, partial(implementation_handler, bang))
end

--vim.api.nvim_set_option("fuzzy_options", {width = 90, height = 60, location = require "fuzzy.lib.location".center})
local options = vim.g.fuzzy_options or {width = 60, height = 40, location = location.center}

local FUZZY_DEFAULT_SORTER = options.sorter or sorter.string_distance
local FUZZY_DEFAULT_DRAWER = options.drawer or drawer.new

M.show_diagnostic = function()
  if diagnostic_list[vim.bo.filetype] ~= nil then
    vim.fn.setqflist({}, " ", {title = "LSP", items = diagnostic_list[vim.bo.filetype]})
    local results = diagnostic_list[vim.bo.filetype]
    if results and not vim.tbl_isempty(results) then
      vim.g.fuzzy_options = {height = #results + 3}
      fuzzy.new {
        source = results,
        sorter = FUZZY_DEFAULT_SORTER,
        drawer = drawer.new({height=#results+5}),
        handler = function(line)
          local segments = split(line, ":")
          helpers.open_file_at(segments[1], segments[2])
        end
      }
    end
  end
end

local function implementation_handler(bang, err, method, result, client_id, bufnr)
  local results = location_handler(err, method, result, client_id, bufnr, "Implementation not found")
  if results and not vim.tbl_isempty(results) then
    local locations = {}

    fuzzy.new {
      source = results,
       --lines,
      sorter = FUZZY_DEFAULT_SORTER,
      drawer = drawer.new({height=#results+5}),
      handler = function(line)
        local segments = split(line, ":")
        helpers.open_file_at(segments[1], segments[2])
      end
    }
  end
end

local function incoming_calls_handler(bang, err, method, result, client_id, bufnr)
  local results = call_hierarchy_handler_from(err, method, result, client_id, bufnr, "Incoming calls not found")
  if results and not vim.tbl_isempty(results) then
    fuzzy.new {
      source = results,
      sorter = FUZZY_DEFAULT_SORTER,
      drawer = drawer.new({height=#results+5}),
      handler = function(line)
        local segments = split(line, ":")
        helpers.open_file_at(segments[1], segments[2])
      end
    }
  end
end

local function outgoing_calls_handler(bang, err, method, result, client_id, bufnr)
  local results = call_hierarchy_handler_to(err, method, result, client_id, bufnr, "Outgoing calls not found")
  if results and not vim.tbl_isempty(results) then
    fuzzy.new {
      source = results,
      sorter = FUZZY_DEFAULT_SORTER,
      drawer = drawer.new({height=#results+5}),
      handler = function(line)
        local segments = split(line, ":")
        helpers.open_file_at(segments[1], segments[2])
      end
    }

  --fzf_locations(bang, "", "Outgoing Calls", results, false)
  end
end

function M.document_symbols(opts)
  opts = opts or {}
  local params = vim.lsp.util.make_position_params()
  params.context = {includeDeclaration = true}
  params.query = ""
  local results_lsp = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, opts.timeout or 10000)
  local locations = {}
  for _, server_results in pairs(results_lsp) do
    if server_results.result then
      vim.list_extend(locations, vim.lsp.util.symbols_to_items(server_results.result) or {})
    end
  end
  local lines = {}
  vim.g.fuzzy_options = {height = #lines + 3}

  for _, loc in ipairs(locations) do
    table.insert(lines, string.format("%s:%s:%s", loc.filename, loc.lnum, loc.text))
  end
  local cmd = table.concat(lines, "\n")
  fuzzy.new {
    source = lines,
    sorter = FUZZY_DEFAULT_SORTER,
    drawer = drawer.new({height=#lines+5}),
    handler = function(line)
      local segments = split(line, ":")
      helpers.open_file_at(segments[1], segments[2])
    end
  }
end

function M.workspace_symbols(opts)
  opts = opts or {}
  local params = vim.lsp.util.make_position_params()
  params.context = {includeDeclaration = true}
  params.query = ""
  local results_lsp = vim.lsp.buf_request_sync(0, "workspace/symbol", params, opts.timeout or 10000)
  local locations = {}
  for _, server_results in pairs(results_lsp) do
    if server_results.result then
      vim.list_extend(locations, vim.lsp.util.symbols_to_items(server_results.result) or {})
    end
  end
  local lines = {}

  vim.g.fuzzy_options = {height = #lines + 3}
  for _, loc in ipairs(locations) do
    table.insert(lines, string.format("%s:%s:%s", loc.filename, loc.lnum, loc.text))
  end
  fuzzy.new {
    source = lines,
    handler = function(line)
      local segments = split(line, ":")
      helpers.open_file_at(segments[1], segments[2])
    end,
    sorter = FUZZY_DEFAULT_SORTER,
    drawer = drawer.new({height=#lines+5})
  }
end

function M.references(opts)
  opts = opts or {}
  local params = vim.lsp.util.make_position_params()
  params.context = {includeDeclaration = true}
  local results_lsp = vim.lsp.buf_request_sync(0, "textDocument/references", params, opts.timeout or 10000)
  local locations = {}
  for _, server_results in pairs(results_lsp) do
    if server_results.result then
      vim.list_extend(locations, vim.lsp.util.locations_to_items(server_results.result) or {})
    end
  end
  local callback = function(line)
    local segments = split(line, ":")
    helpers.open_file_at(segments[1], segments[2])
  end
  opts.callback = callback
  local lines = {}

  vim.g.fuzzy_options = {height = #lines + 3}
  for _, loc in ipairs(locations) do
    table.insert(lines, string.format("%s:%s:%s", loc.filename, loc.lnum, loc.text))
  end
  fuzzy.new {
    source = lines,
    handler = function(line)
      local segments = split(line, ":")
      helpers.open_file_at(segments[1], segments[2])
    end,
    sorter = FUZZY_DEFAULT_SORTER,
    drawer = drawer.new({height=#lines+5})
  }
end

M.incoming_calls_call = partial(M.incoming_calls, 0)
M.outgoing_calls_call = partial(M.outgoing_calls, 0)
M.implementation_call = partial(M.implementation, 0)

M.incoming_calls_handler = partial(incoming_calls_handler, 0)
M.outgoing_calls_handler = partial(outgoing_calls_handler, 0)
M.implementation_handler = partial(implementation_handler, 0)

vim.lsp.handlers["textDocument/implementation"] = M.implementation_handler

vim.lsp.handlers["callHierarchy/incomingCalls"] = M.incoming_calls_handler
vim.lsp.handlers["callHierarchy/outgoingCalls"] = M.outgoing_calls_handler

return M
