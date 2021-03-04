local api = vim.api
local lspconfig = require 'lspconfig'
local global = require 'core.global'
local format = require('modules.completion.format')
local lsp_status = require('lsp-status')


vim.cmd [[packadd lspsaga.nvim]]
local saga = require 'lspsaga'
saga.init_lsp_saga()

if not packer_plugins['nvim-lua/lsp-status.nvim'] or not packer_plugins['lsp-status.nvim'].loaded then
  vim.cmd [[packadd lsp-status.nvim]]
end
local lsp_status = require('lsp-status')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

function auto_group()

    -- use with care. some project does not like the idea of auto-format, esp c/c++, js....
  local file_types = "c,cpp,go,python,vim,sh,javascript,html,css,lua,typescript"
  local format_files =  "c,cpp,go,python,vim,javascript,typescript"  --html,css,
  vim.api.nvim_command [[augroup nvim_lsp_autos]]
  vim.api.nvim_command [[autocmd!]]

    -- vim.api.nvim_command([[autocmd FileType ]] .. format_files .. [[ autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos BufWritePre <buffer> silent! lua vim.lsp.diagnostic.set_loclist({open_loclist = false})]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    -- vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos BufWinEnter <buffer> lua redraw_diagnostic()]])

    --[[ mappings that are shared across all supported langs ]]--
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gR      <cmd>lua vim.lsp.buf.references()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ imap <silent> <m-k>   <cmd>lua vim.lsp.buf.signature_help()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gs      <cmd>lua vim.lsp.buf.signature_help()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> g0      <cmd>lua vim.lsp.buf.document_symbol()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <leader> g0      <cmd>Vista finder clap<CR>]])  --use clap
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gW      <cmd>lua vim.lsp.buf.workspace_symbol()<CR>]]) --lsputil or telescope

    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <c-]>   <cmd>lua vim.lsp.buf.definition()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> de      <cmd>lua vim.lsp.buf.declaration()<CR>]]) --?
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <Leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>]])

    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gD      <cmd>lua vim.lsp.buf.implementation()<CR>]])  --lsputil
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gt      <cmd>lua vim.lsp.buf.type_definition()<CR>]])  --? no for go
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gL      <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <C-LeftMouse> <cmd>lua vim.lsp.buf.definition()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> g<LeftMouse> <cmd>lua vim.lsp.buf.implementation()<CR>]])
    vim.api.nvim_command([[nnoremap <leader>gr <cmd>lua require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>]])
    vim.api.nvim_command([[autocmd VimEnter * nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>]])
    vim.api.nvim_command([[autocmd VimEnter * nnoremap <buffer> <silent> g<LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.implementation()<CR>]])
  vim.api.nvim_command([[augroup END]])

end

local diagnostic_map = function (bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']O', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  require'lsp_signature'.on_attach()
  diagnostic_map(bufnr)
  -- lspsaga
  require 'utils.highlight'.add_highlight()

  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  -- https://github.com/fsouza
  vim.lsp.handlers['textDocument/documentHighlight'] = function(_, _, result, _)
    if not result then
      return
    end
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.util.buf_clear_references(bufnr)
    vim.lsp.util.buf_highlight_references(bufnr, result)
  end


  -- vim.lsp.handlers['window/showMessage'] = function(err, method, params, client_id)
  --   if params and params.type <= vim.lsp.message_level then
  --     assert(vim.lsp.handlers["window/showMessage"], "Callback for window/showMessage notification is not defined")
  --     vim.lsp.handlers["window/showMessage"](err, method, params, client_id)
  --   end
  -- end

  -- vim.lsp.handlers["window/logMessage"] = function log_message(err, method, result, client_id)
  --   local message_type = result.type
  --   local message = result.message
  --   local client = vim.lsp.get_client_by_id(client_id)
  --   local client_name = client and client.name or string.format("id=%d", client_id)
  --   if not client then
  --     err_message("LSP[", client_name, "] client has shut down after sending the message")
  --   end
  --   local message_type_name = vim.lsp.protocol.MessageType[message_type]
  --   vim.api.nvim_out_write(string.format("LSP[%s][%s] %s\n", client_name, message_type_name, message))
  --   return result
  -- end

  -- hdlr alternatively, use lua vim.lsp.diagnostic.set_loclist({open_loclist = false})  -- true to open loclist
  local diag_hdlr =  function(err, method, result, client_id, bufnr, config)
    -- vim.lsp.diagnostic.clear(vim.fn.bufnr(), client.id, nil, nil)
    vim.lsp.diagnostic.on_publish_diagnostics(err, method, result, client_id, bufnr, config)
    if result and result.diagnostics then
        local item_list = {}
        local s = result.uri
        local fname = s
        for _, v in ipairs(result.diagnostics) do
            i, j = string.find(s, "file://")
            if j then
              fname = string.sub(s, j + 1)
            end
            table.insert(item_list, { filename = fname, lnum = v.range.start.line + 1, col = v.range.start.character + 1; text = v.message; })
        end
        local old_items = vim.fn.getqflist()
        for _, old_item in ipairs(old_items) do
            local bufnr = vim.uri_to_bufnr(result.uri)
            if vim.uri_from_bufnr(old_item.bufnr) ~= result.uri then
                    table.insert(item_list, old_item)
            end
        end
        vim.fn.setqflist({}, ' ', { title = 'LSP'; items = item_list; })
      end
    end


  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    diag_hdlr,
    {
      -- Enable underline, use default values
      underline = true,
      -- Enable virtual text, override spacing to 0
      virtual_text = {
        spacing = 0,
        prefix = '', --'',  
      },
      -- Use a function to dynamically turn signs off
      -- and on, using buffer local variables
      signs = true,
      -- Disable a feature
      update_in_insert = false,
    }
  )

  vim.lsp.handlers['textDocument/hover'] = function(_, method, result)
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

  vim.cmd [[packadd vim-illuminate]]
  require 'illuminate'.on_attach(client)
  require 'utils.lspkind'.init()


  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require 'utils.lspkind'.init()


  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

end

auto_group()

local mini_attach = function(client,bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end


local enhance_attach = on_attach

local servers = { 'gopls', 'tsserver', 'bashls', 'dockerls', 'pyls', 'sumneko_lua', 'vimls', 'html', 'jsonls', 'cssls', 'yamlls', 'clangd', 'sqls'}
for _, lsp in ipairs(servers) do
  lsp_status.register_progress()

  lsp_status.config({
    status_symbol = '',
    indicator_errors = '', --'',
    indicator_warnings = '', --'',
    indicator_info = '﯎',--'',
    indicator_hint = '💡',
    indicator_ok = '',--'✔️',
    spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
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

      return require('lsp-status.util').in_range(cursor_pos, value_range)
    end
  end,
  })
  require 'utils.highlight'.diagnositc_config_sign()
  require 'utils.highlight'.add_highlight()
end


for _, lsp in ipairs({ 'tsserver', 'bashls', 'dockerls', 'vimls', 'html', 'jsonls', 'cssls', 'yamlls'}) do
  lspconfig[lsp].setup {
    message_level = vim.lsp.protocol.MessageType.Error;
    log_level = vim.lsp.protocol.MessageType.Error;
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end


lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,
  },

  message_level = vim.lsp.protocol.MessageType.Error;
  cmd = {
      "gopls",

      -- share the gopls instance if there is one already
      -- "-remote=auto",

      --[[ debug options ]]--
      --"-logfile=auto",
      --"-debug=:0",
      --"-remote.debug=:0",
      --"-rpc.trace",
  },
    settings = {
      gopls = {
        gofumpt = true,
        analyses = {
          unusedparams = true,
          unreachable = false,
        },
        codelenses = {
          generate = true, -- show the `go generate` lens.
          gc_details = true, --  // Show a code lens toggling the display of gc's choices.
        },
        usePlaceholders    = true,
        completeUnimported = true,
        staticcheck = true,
        matcher            = "fuzzy",
        symbolMatcher      = "fuzzy",
        gofumpt            = true,
        buildFlags = {"-tags", "integration"},
        -- buildFlags = {"-tags", "functional"}
      },
    },
    root_dir = function(fname)
      local util = require('lspconfig').util
      return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
    end;
}

lspconfig.sqls.setup({
  on_attach = function(client)
    client.resolved_capabilities.execute_command = true
      lsp_status.on_attach(client, bufnr)
      diagnositc_config_sign()
    require'sqls'.setup{picker = 'telescope',} -- or default
  end,
  settings = {
    cmd = {"sqls", "-config", "$HOME/.config/sqls/config.yml"},
    -- alterantively:
    -- connections = {
    --   {
    --     driver = 'postgresql',
    --     dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=password dbname=user_db sslmode=disable',
    --   },
    -- },
    workspace = {
      library = {
        -- This loads the `lua` files from nvim into the runtime.
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("~/repos/nvim/lua")] = true,
      },
    },
  },
})

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end


-- lua setup
-- local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-serve"
local sumneko_root_path = vim.fn.expand("$HOME")..'/github/sumneko/lua-language-server'
local sumneko_binary = vim.fn.expand("$HOME")..'/github/sumneko/lua-language-server/bin/macOS/lua-language-server'

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "describe",
          "it",
          "before_each",
          "after_each",
          "teardown",
          "pending",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          [vim.fn.expand("~/repos/nvim/lua")] = true,
        },
      },
    },
  },
}


lspconfig.tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    enhance_attach(client)
  end
}

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
}

local servers = {
  'dockerls','bashls','rust_analyzer','pyls'
}

for _,server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = enhance_attach
  }
end
