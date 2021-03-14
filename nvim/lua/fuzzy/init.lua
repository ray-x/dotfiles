local fuzzy = require('fuzzy.lib')
local helpers = require('fuzzy.lib.helpers')
local source = require('fuzzy.lib.source')
local sorter = require('fuzzy.lib.sorter')
local drawer = require('fuzzy.lib.drawer')
local projects = require'fuzzy.lib.projects'

-- Register execute commands
-- vim.cmd [[ command! IFiles lua require('fuzzy').interactive_finder{} ]]
-- vim.cmd [[ command! Files lua require('fuzzy').file_finder{} ]]
-- vim.cmd [[ command! Grep lua require('fuzzy').grep{} ]]
-- vim.cmd [[ command! Commands lua require('fuzzy').commands{} ]]
-- vim.cmd [[ command! MRU lua require('fuzzy').mru{} ]]
-- vim.cmd [[ command! BLines lua require('fuzzy').buffer_lines{} ]]
-- vim.cmd [[ command! Cd lua require('fuzzy').cd{} ]]
-- vim.cmd [[ command! GitFiles lua require('fuzzy').git_files{} ]]
-- vim.cmd [[ command! GitGrep lua require('fuzzy').git_grep{} ]]
-- vim.cmd [[ command! Buffers lua require('fuzzy').buffers{} ]]
-- vim.cmd [[ command! Rg lua require('fuzzy').rg{} ]]
-- vim.cmd [[ command! Colors lua require('fuzzy').colors{} ]]
vim.cmd [[ command! LspReferences lua require('fuzzy').lsp_references{} ]]
vim.cmd [[ command! LspDocumentSymbols lua require('fuzzy').lsp_document_symbols{} ]]
vim.cmd [[ command! LspWorkspaceSymbols lua require('fuzzy').lsp_workspace_symbols{} ]]

local options = vim.g.fuzzy_options or {height=40, width=60}
-- Defaults
local FUZZY_DEFAULT_SORTER = options.sorter or sorter.string_distance
local FUZZY_DEFAULT_DRAWER = options.drawer or drawer.new

local M = {}

function M.lsp_document_symbols(opts)
  opts = opts or {}
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = true }
  params.query = ''
  local results_lsp = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, opts.timeout or 10000)
  local locations = {}
  for _, server_results in pairs(results_lsp) do
    if server_results.result then
      vim.list_extend(locations, vim.lsp.util.symbols_to_items(server_results.result) or {})
    end
  end
  local lines = {}
  for _, loc in ipairs(locations) do
    table.insert(lines, string.format('%s:%s:%s', loc.filename, loc.lnum, loc.text))
  end
  local cmd = table.concat(lines, '\n')
  fuzzy.new {
    source = lines,
    sorter = FUZZY_DEFAULT_SORTER,
    drawer = drawer.new({height=#lines+3}),
    handler = function(line)
      local segments = split(line, ":")
      helpers.open_file_at(segments[1], segments[2])
    end
  }
end

function M.lsp_workspace_symbols(opts)
  opts = opts or {}
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = true }
  params.query = ''
  local results_lsp = vim.lsp.buf_request_sync(0, "workspace/symbol", params, opts.timeout or 10000)
  local locations = {}
  for _, server_results in pairs(results_lsp) do
    if server_results.result then
      vim.list_extend(locations, vim.lsp.util.symbols_to_items(server_results.result) or {})
    end
  end
  local lines = {}
  for _, loc in ipairs(locations) do
    table.insert(lines, string.format('%s:%s:%s', loc.filename, loc.lnum, loc.text))
  end
  fuzzy.new {
    source = lines,
    handler = function(line)
      local segments = split(line, ":")
      helpers.open_file_at(segments[1], segments[2])
    end,
    sorter = FUZZY_DEFAULT_SORTER,
    drawer = drawer.new({height=#lines+3}),
  }
end

function M.lsp_references(opts)
  opts = opts or {}
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = true }
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
  for _, loc in ipairs(locations) do
    table.insert(lines, string.format('%s:%s:%s', loc.filename, loc.lnum, loc.text))
  end
  fuzzy.new {
    source = lines,
    handler = function(line)
      local segments = split(line, ":")
      helpers.open_file_at(segments[1], segments[2])
    end,
    sorter = FUZZY_DEFAULT_SORTER,
    drawer = drawer.new({height=#lines+3}),
  }
end



return M
