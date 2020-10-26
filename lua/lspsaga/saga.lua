local global = require 'global'
local syntax = require 'lspsaga.syntax'
local server = require 'lspsaga.serverconf'
local callbacks = require 'lspsaga.callbacks'
local autocmd = require 'event'
local vim,api= vim,vim.api

-- A table to store our root_dir to client_id lookup. We want one LSP per
-- root directory, and this is how we assert that.
local lsp_store = {}
local filetype_server_map = {}

local function add_hook_after(func, new_fn)
  if func then
    return function(...)
      -- TODO which result?
      func(...)
      return new_fn(...)
    end
  else
    return new_fn
  end
end

local function add_options(server_setup)
  local options = {
    callbacks = {};
    capabilities = vim.lsp.protocol.make_client_capabilities();
    settings = vim.empty_dict();
    init_options = vim.empty_dict();
    log_level = vim.lsp.protocol.MessageType.Warning;
    message_level = vim.lsp.protocol.MessageType.Warning;
  };

  for option,value in pairs(options) do
    if not global.has_key(server_setup,option) then
      server_setup[option] = value
    end
  end

  server_setup.capabilities = vim.tbl_deep_extend('keep', server_setup.capabilities, {
    workspace = {
      configuration = true;
    }
  })

  server_setup.on_init = add_hook_after(server_setup.on_init, function(client, _)
        function client.workspace_did_change_configuration(settings)
          if not settings then return end
          if vim.tbl_isempty(settings) then
            settings = {[vim.type_idx]=vim.types.dictionary}
          end
          return client.notify('workspace/didChangeConfiguration', {
            settings = settings;
          })
        end
        if not vim.tbl_isempty(server_setup.settings) then
          client.workspace_did_change_configuration(server_setup.settings)
        end
      end)

  server_setup._on_attach = server_setup.on_attach;

  callbacks.add_callbacks(server_setup)

  return server_setup
end

  -- Some path manipulation utilities
local function is_dir(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == 'directory' or false
end

  -- Asumes filepath is a file.
local function dirname(filepath)
  local is_changed = false
  local result = filepath:gsub(global.path_sep.."([^"..global.path_sep.."]+)$", function()
    is_changed = true
    return ""
  end)
  return result, is_changed
end

local function path_join(...)
  return table.concat(vim.tbl_flatten {...}, global.path_sep)
end

-- Ascend the buffer's path until we find the rootdir.
-- is_root_path is a function which returns bool
local function buffer_find_root_dir(bufnr, is_root_path)
  local bufname = api.nvim_buf_get_name(bufnr)
  if vim.fn.filereadable(bufname) == 0 then
    return nil
  end
  local dir = bufname
  -- Just in case our algo is buggy, don't infinite loop.
  for _ = 1, 100 do
    local did_change
    dir, did_change = dirname(dir)
    if is_root_path(dir, bufname) then
      return dir, bufname
    end
    -- If we can't ascend further, then stop looking.
    if not did_change then
      return nil
    end
  end
end

local lspsaga = {}

function lspsaga.start_lsp_server()
  local client_id = nil
  local bufnr = api.nvim_get_current_buf()
  local buf_filetype = api.nvim_buf_get_option(bufnr,'filetype')
  -- Filter which files we are considering.
  if not global.has_key(filetype_server_map,buf_filetype) then
    -- load completion in buffer for complete something else
    return
  end

  local server_setup = server[filetype_server_map[buf_filetype]]

  -- Try to find our root directory.
  local root_dir = buffer_find_root_dir(bufnr, function(dir)
    for _,root_file in pairs(server_setup.root_patterns) do
      if vim.fn.filereadable(path_join(dir, root_file)) == 1 then
        return true
      elseif is_dir(path_join(dir, root_file)) then
        return true
      end
    end
  end)

  -- We couldn't find a root directory, so ignore this file.
  if not root_dir then
    print(string.format("initialize %s failed doesn't find root_dir",server_setup.name))
    return
  end

  -- If the current file root dir in cache,we just attach it
  -- also the completion already in runtimepath just to call it
  if lsp_store[root_dir] ~= nil then
    client_id = lsp_store[root_dir]
    vim.lsp.buf_attach_client(bufnr, client_id)
    return
  end

  local on_attach = function(client,bufnr)
    if not vim.o.runtimepath:find('completion-nvim') then
      vim.o.runtimepath = vim.o.runtimepath ..','.. global.cache_dir ..'dein/repos/github.com/nvim-lua/completion-nvim.lua'
    end
    local has_completion,completion = pcall(require,'completion-nvim')
    if has_completion then
      -- passing in a table with on_attach function
      completion.on_attach()
    end

    local lsp_event = {}
    if client.resolved_capabilities.document_highlight then
      lsp_event.highlights = {
        {"CursorHold,CursorHoldI","<buffer>", "lua vim.lsp.buf.document_highlight()"};
        {"CursorMoved","<buffer>","lua vim.lsp.buf.clear_references()"};
      }
    end
    if client.resolved_capabilities.document_formatting then
      if vim.api.nvim_buf_get_option(bufnr, "filetype") == "go" then
        lsp_event.organizeImports = {
          {"BufWritePre","*.go","lua require('lspsaga.provider').go_organize_imports_sync(1000)"}
        }
      end
      lsp_event.autoformat = {
        {"BufWritePre","*" ,"lua vim.lsp.buf.formatting_sync(nil, 1000)"}
      }
    end
    -- register lsp event
    autocmd.nvim_create_augroups(lsp_event)
    -- api.nvim_command("autocmd CompleteDone <buffer> lua require'lsp.callbacks'.show_signature_help()")
    -- Source omnicompletion from LSP.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  -- config the server config on_attach
  server_setup.on_attach= on_attach
    -- build a new server config
  local new_config = vim.tbl_extend("error",add_options(server_setup), {
    root_dir = root_dir;
  })
  -- start a new lsp server and store the cliend_id
  client_id = vim.lsp.start_client(new_config)
  if client_id ~= nil then
    lsp_store[root_dir] = client_id
    vim.lsp.buf_attach_client(bufnr, client_id)

    syntax.add_highlight()
  end
end

function lspsaga.create_saga_augroup()
  if vim.tbl_isempty(server) then return end
  for server_name,value in pairs(server) do
    if type(value) == 'table' then
      for _,filetype in pairs(value.filetypes) do
        filetype_server_map[filetype] = server_name
      end
    end
  end
  vim.api.nvim_command('augroup lsp_saga_event')
  vim.api.nvim_command('autocmd!')
  for ft, _ in pairs(filetype_server_map) do
    vim.api.nvim_command(string.format('autocmd FileType %s lua require("lspsaga.saga").start_lsp_server()',ft))
  end
  vim.api.nvim_command('augroup END')
end

return lspsaga
