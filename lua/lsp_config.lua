local nvim_lsp = require('lspconfig')
local util = require('lspconfig').util
local lsp_status = require('lsp-status')

local status = require('lspsaga.status')
vim.lsp.set_log_level("error")

print("lsp_config is loading")

local M = {}

vim.g.lsp_utils_location_opts = {
  height = 24,
  mode = 'editor',
  preview = {
    title = 'Location Preview'
  },
  keymaps = {
    n = {
      ['<C-n>'] = 'j',
      ['<C-p>'] = 'k',
    }
  }
}

vim.g.lsp_utils_symbols_opts = {
  height = 0,
  mode = 'editor',
  preview = {
    title = 'Symbol Preview'
  },
  keymaps = {
    n = {
      ['<C-n>'] = 'j',
      ['<C-p>'] = 'k',
    }
  }
}


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

      return require('lsp-status.util').in_range(cursor_pos, value_range)
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


function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

function auto_group()
  
    -- use with care. some project does not like the idea of auto-format, esp c/c++, js....
  local file_types = "c,cpp,go,python,vim,sh,javascript,html,css,lua,typescript"
  local format_files =  "c,cpp,go,python,vim,javascript,typescript"  --html,css,
  vim.api.nvim_command [[augroup nvim_lsp_autos]]
  vim.api.nvim_command [[autocmd!]]
    vim.api.nvim_command("au BufWritePre *.go lua require('lspsaga.action').go_organize_imports_sync(1000) ")

    vim.api.nvim_command([[autocmd FileType ]] .. format_files .. [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil,500)]])

    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ autocmd nvim_lsp_autos CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    
    --[[ mappings that are shared across all supported langs ]]--
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gr      <cmd>lua vim.lsp.buf.references()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> K       <cmd>lua vim.lsp.buf.hover()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <c-k>   <cmd>lua vim.lsp.buf.signature_help()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gs      <cmd>lua vim.lsp.buf.signature_help()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> g0      <cmd>lua vim.lsp.buf.document_symbol()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <leader>g0       <cmd>Vista finder clap<CR>]])  --use clap
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gW      <cmd>lua vim.lsp.buf.workspace_symbol()<CR>]]) --lsputil or telescope 

    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <c-]>   <cmd>lua vim.lsp.buf.definition()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> de      <cmd>lua vim.lsp.buf.declaration()<CR>]]) --?
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <Leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>]])

    -- im.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gd      <cmd>lua vim.lsp.buf.declaration()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gd      <cmd>lua require'lspsaga.provider'.preview_definiton()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gD      <cmd>lua vim.lsp.buf.implementation()<CR>]])  --lsputil
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gt      <cmd>lua vim.lsp.buf.type_definition()<CR>]])  --? no for go
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> ga      <cmd>lua vim.lsp.buf.code_action()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gL      <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]])

    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> [e      <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> ]e      <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> ce      <cmd>lua require'lspsaga.diagnostic'.show_buf_diagnostics()<CR>]])

    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> gh      <cmd>lua require'lspsaga.provider'.lsp_finder({definition_icon='  ',reference_icon = '  '})<CR>"]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> di      <cmd>lua require('lspsaga.location').preview_implementation()<CR>]])    
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> df      <cmd>lua require('lspsaga.location').peek_definition()<CR>]])


    -- vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <Leader>gr       <cmd>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({results_height = 20; width = 0.6; preview_width = 0.5}))<CR>]])
    -- vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> td      <cmd>lua require'telescope.builtin'.lsp_document_symbols(theme)<CR>]])
    -- vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> tw      <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>]])  -- not with golang
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> <C-LeftMouse> <cmd>lua vim.lsp.buf.definition()<CR>]])
    vim.api.nvim_command([[autocmd FileType ]] .. file_types .. [[ nnoremap <silent> g<LeftMouse> <cmd>lua vim.lsp.buf.implementation()<CR>]])

  vim.api.nvim_command([[augroup END]])


end

local diagnostic_map = function (bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', ':lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', ':lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[D', ':lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']D', ':lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']O', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- lsp sign
local diagnositc_config_sign = function ()
  vim.fn.sign_define('LspDiagnosticsSignError', {text='', texthl='LspDiagnosticsSignError',linehl='', numhl=''})
  vim.fn.sign_define('LspDiagnosticsSignWarning', {text='', texthl='LspDiagnosticsSignWarning', linehl='', numhl=''})
  vim.fn.sign_define('LspDiagnosticsSignInformation', {text='', texthl='LspDiagnosticsSignInformation', linehl='', numhl=''})
  vim.fn.sign_define('LspDiagnosticsSignHint', {text='', texthl='LspDiagnosticsSignHint', linehl='', numhl=''})
end

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  diagnostic_map(bufnr)
  -- lspsaga
  diagnositc_config_sign()
  require 'lspsaga.syntax'.add_highlight()


  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- hook to nvim-lsputils
  vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
  vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler

  -- https://github.com/fsouza
  vim.lsp.handlers['textDocument/documentHighlight'] = function(_, _, result, _)
    if not result then
      return
    end
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.util.buf_clear_references(bufnr)
    vim.lsp.util.buf_highlight_references(bufnr, result)
  end
  
  -- us telescope for following binding
  vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
  vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
  
  vim.lsp.handlers['window/showMessage'] = function(err, method, params, client_id)
    if params and params.type <= vim.lsp.message_level then
      assert(vim.lsp.handlers["window/showMessage"], "Callback for window/showMessage notification is not defined")
      vim.lsp.handlers["window/showMessage"](err, method, params, client_id)
    end
  end

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

  local hdlr =  function(err, method, result, client_id)
    vim.lsp.diagnostic.on_publish_diagnostics(err, method, result, client_id, bufnr, config)
    if result and result.diagnostics then
        local item_list = {}
        for _, v in ipairs(result.diagnostics) do
            local fname = result.uri
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
    vim.lsp.diagnostic.on_publish_diagnostics, 
    {
      -- Enable underline, use default values
      underline = true,
      -- Enable virtual text, override spacing to 4
      virtual_text = {
        spacing = 0,
        prefix = '',
      },
      -- Use a function to dynamically turn signs off
      -- and on, using buffer local variables
      signs = function(bufnr, client_id)


        local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
        -- No buffer local variable set, so just enable by default
        if not ok then
          return true
        end

        return result
      end,
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

end

-- 

auto_group()

-- , 'dockerls' 'ccls' pyls_ms

local servers = { 'gopls', 'tsserver', 'bashls', 'pyls', 'sumneko_lua', 'vimls', 'html', 'jsonls', 'cssls', 'yamlls', 'clangd'}
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
    message_level = vim.lsp.protocol.MessageType.Error;
    log_level = vim.lsp.protocol.MessageType.Error;
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
  }
end


-- --[[ Go ]]--
nvim_lsp.gopls.setup {
    on_attach=on_attach,
    capabilities = lsp_status.capabilities,
    message_level = vim.lsp.protocol.MessageType.Error;
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
        buildFlags = {"-tags", "integration"},
        -- buildFlags = {"-tags", "functional"}
      },
    },
    root_dir = function(fname)
      return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
    end;
}

-- nvim_lsp.sqls.setup({settings = {
--     on_attach=on_attach,
--     cmd = {"sqls", "-config", "$HOME/.config/sqls/config.yml"},
--     workspace = {
--       library = {
--         -- This loads the `lua` files from nvim into the runtime.
--         [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--         [vim.fn.expand("~/repos/nvim/lua")] = true,
--       },
--     },
--   },
-- })

-- require'lspconfig'.sqlls.setup{
--   cmd = {"sql-language-server", "up", "--method", "stdio"};
-- }

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

-- nvim_lsp.sumneko_lua.setup({settings = {
--     on_attach=on_attach,
--     --cmd = {'/Users/ray.xu/github/sumneko/lua-language-server/bin/macOS/lua-language-server'},
--     Lua = {
--       runtime = {
--           version = "LuaJIT", 
--           path = vim.split(package.path, ";")
--           },
--       diagnostics = {
--         enable = true,
--         globals = {
--           "vim",
--           "describe",
--           "it",
--           "before_each",
--           "after_each",
--           "teardown",
--           "pending",
--         },
--       },
--       completion = {keywordSnippet = "Disable"},
--       workspace = {
--         library = {
--           -- This loads the `lua` files from nvim into the runtime.
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.expand("~/repos/nvim/lua")] = true,
--         },
--       },
--     },
--   },
-- })



-- Some arbitrary servers
nvim_lsp.clangd.setup({
  handlers = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true
  },

  on_attach = on_attach,
  capabilities = lsp_status.capabilities
})

-- nvim_lsp.pyls_ms.setup({
--   handlers = lsp_status.extensions.pyls_ms.setup(),
--   settings = { python = { workspaceSymbols = { enabled = true }}},
--   on_attach = on_attach,
--   capabilities = lsp_status.capabilities
-- })

nvim_lsp.pyls.setup({
  settings = { python = { workspaceSymbols = { enabled = true }}},
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
})



-- nvim_lsp.tsserver.setup({
--   handlers = lsp_status.extensions.tsserver.setup(),
--   settings = { python = { workspaceSymbols = { enabled = true }}},
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities
-- })



-- nvim_lsp.ghcide.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities
-- })
-- nvim_lsp.rust_analyzer.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities
-- })



return M
