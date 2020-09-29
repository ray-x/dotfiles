

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
" nnoremap <silent> <leader>df    <cmd>lua peek_definition()<CR>
nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer> <silent> g<LeftMouse> <LeftMouse> <cmd>lua vim.lsp.buf.implementation()<CR>

set completeopt=menuone,noinsert,noselect

autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc
let g:completion_chain_complete_list = [
            \{'ins_complete': v:false, 'complete_items': ['lsp', 'snippet', 'buffers', 'tabnine']},
            \{'mode': '<c-p>'},
            \{'mode': '<c-n>'}
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

let g:completion_enable_snippet = 'vim-vsnip'  " 'UltiSnips' 'vim-vsnip'

let g:completion_matching_strategy_list = ['exact', 'substring']   "'fuzzy','all'"
augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::', '->']
augroup end

sign define LspDiagnosticsErrorSign text=  linehl= texthl=LspDiagnosticsErrorSign numhl=                        
sign define LspDiagnosticsWarningSign text=  linehl= texthl=LspDiagnosticsWarningSign numhl=                    
sign define LspDiagnosticsInformationSign text=כֿ  linehl= texthl=LspDiagnosticsInformationSign numhl=            
sign define LspDiagnosticsHintSign text=λ  linehl= texthl=LspDiagnosticsHintSign numhl= 



function! LspStatus() abort
    let sl = ''
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
        let sl.='%#MyStatuslineLSP#E:'
        let sl.='%#MyStatuslineLSPErrors#%{luaeval("vim.lsp.util.buf_diagnostics_count([[Error]])")}'
        let sl.='%#MyStatuslineLSP# W:'
        let sl.='%#MyStatuslineLSPWarnings#%{luaeval("vim.lsp.util.buf_diagnostics_count([[Warning]])")}'
    else
        let sl.='%#MyStatuslineLSPErrors#off'
    endif
    return sl
endfunction
let &l:statusline = '%#MyStatuslineLSP#LSP '.LspStatus()


let g:completion_word_min_length = 2
let g:completion_trigger_keyword_length = 1

" max tabnine completion options(default 7)
let g:completion_tabnine_max_num_results=7

" sort by tabnine score (default 0)
let g:completion_tabnine_sort_by_details=1

" max line for tabnine input(default 1000)
" from current line -1000 ~ +1000 lines is passed as input
let g:completion_tabnine_max_lines=1000

let g:completion_auto_change_source = 1
" imap <c-j> <Plug>(completion_next_source) "use <c-j> to switch to previous completion
" imap <c-k> <Plug>(completion_prev_source) "use <c-k> to switch to next completion
"  sorting via length descending
" possible value: "length", "alphabet", "none"
let g:completion_sorting = "length"
let g:completion_matching_ignore_case = 1
let g:completion_items_priority = {
        \ 'Field': 5,
        \ 'Function': 7,
        \ 'Variables': 7,
        \ 'Method': 10,
        \ 'Interfaces': 5,
        \ 'Constant': 5,
        \ 'Class': 5,
        \ 'Keyword': 4,
        \ 'UltiSnips' : 2,
        \ 'vim-vsnip' : 3,
        \ 'Neosnippet' : 2,
        \ 'Buffers' : 1,
        \ 'TabNine' : 2,
        \ 'File' : 1,
        \}

" au BufEnter * if &ft == 'markdown' | lua  require'completion'.on_attach() | endif
autocmd BufEnter * lua require'completion'.on_attach()

augroup CompletionMD
    autocmd!
    autocmd BufEnter *.md let g:completion_matching_strategy_list = ['substring'] 
    autocmd FileType markdown let g:completion_items_priority = { 'Buffers' : 7, 'TabNine' : 6, 'File' : 5, 'vim-vsnip' : 8 }
augroup end



let g:LanguageClient_serverCommands = { 
  \ 'typescript': ['typescript-language-server', '--stdio', '--tsserver-path', 'node_modules/.bin/tsserver'], 
\ }

" nnoremap <silent> <Leader>gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
" nnoremap <silent> <Leader>ws <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>
" nnoremap <silent> <Leader>ds <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>