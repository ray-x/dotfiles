lua <<EOF
local nvim_lsp = require('nvim_lsp')
local diagnostic = require('diagnostic')
local completion = require('completion')
local lsp_status = require('lsp-status')
local configs = require('nvim_lsp/configs')
local util = require('nvim_lsp/util')


-- Taken from https://www.reddit.com/r/neovim/comments/gyb077/nvimlsp_peek_defination_javascript_ttserver/
function preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
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

function peek_definition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), floating_win) then
    vim.api.nvim_set_current_win(floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
  end
end

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  diagnostic.on_attach(client, bufnr)
  completion.on_attach(client, bufnr)
  lsp_status.on_attach(client, bufnr)

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>de', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'pd', '<cmd>lua peek_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', ':PrevDiagnostic<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', ':NextDiagnostic<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[D', ':PrevDiagnosticCycle<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']D', ':NextDiagnosticCycle<CR>', opts)
end

local servers = { 'gopls', 'tsserver' }
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
nvim_lsp.gopls.setup{
  root_dir = nvim_lsp.util.root_pattern('.git', '.mod', '.sum');
}
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end
local nvim_lsp = require'nvim_lsp'
local on_attach_vim = function(client, bufnr)
    require'completion'.on_attach(client, bufnr)
    require'diagnostic'.on_attach(client, bufnr)
end
nvim_lsp.gopls.setup{
    on_attach=on_attach_vim
}

require'nvim_lsp'.tsserver.setup{}
cmd = { "typescript-language-server", "--stdio" }
filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }

nvim_lsp.pyls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.sumneko_lua.setup{
  on_attach = on_attach,
}
nvim_lsp.vimls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.tsserver.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}
nvim_lsp.html.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}

EOF


let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_enable_underline = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_insert_delay = 1
" some shortcuts
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

set completeopt=menuone,noinsert,noselect

autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc
let g:completion_chain_complete_list = [
            \{'complete_items': ['lsp', 'snippet']},
            \]
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()
let g:completion_enable_snippet = 'UltiSnips'

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::', '->']
augroup end

sign define LspDiagnosticsErrorSign text=  linehl= texthl=LspDiagnosticsErrorSign numhl=                        
sign define LspDiagnosticsWarningSign text=  linehl= texthl=LspDiagnosticsWarningSign numhl=                    
sign define LspDiagnosticsInformationSign text=כֿ  linehl= texthl=LspDiagnosticsInformationSign numhl=            
sign define LspDiagnosticsHintSign text=λ  linehl= texthl=LspDiagnosticsHintSign numhl= 