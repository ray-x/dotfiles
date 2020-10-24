local global = require 'global'
local syntax = require 'lsp.syntax'
local server = require 'lsp.serverconf'
local callbacks = require 'lsp.callbacks'
local autocmd = require 'event'
local vim,api= vim,vim.api

-- A table to store our root_dir to client_id lookup. We want one LSP per
-- root directory, and this is how we assert that.
local lsp_store = {}

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

local function load_completion()
  local loaded,completion = pcall(require,'completion')
  if loaded then
    completion.on_attach()
  end
end

-- async load completion-nvm then initialize lsp server
function lsp_store.start_lsp_server()
  local client_id = nil
  local bufnr = api.nvim_get_current_buf()
  local buf_filetype = api.nvim_buf_get_option(bufnr,'filetype')
  local filetype_server_map = server.load_filetype_server()
  -- Filter which files we are considering.
  if not global.has_key(filetype_server_map,buf_filetype) then
    -- load completion in buffer for complete something else
    load_completion()
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
    load_completion()
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

  Completion_loaded = false
  -- async load completion
  local timer = vim.loop.new_timer()
  timer:start(10,0,vim.schedule_wrap(function()
    local has_completion,completion = pcall(require,'completion')
    if has_completion and not Completion_loaded then
       Completion_loaded = true

      local on_attach = function(client,bufnr)
        -- passing in a table with on_attach function
        completion.on_attach()

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
              {"BufWritePre","*.go","lua require('lsp.provider').go_organize_imports_sync(1000)"}
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
      if client_id ~= nil and timer:is_closing() == false then
        lsp_store[root_dir] = client_id
        vim.lsp.buf_attach_client(bufnr, client_id)

        syntax.add_highlight()
        timer:stop()
        timer:close()
      end
    end
  end))
end

return lsp_store
