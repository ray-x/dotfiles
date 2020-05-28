" ycm
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_python_binary_path = 'python3'
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nmap <F4> :YcmDiags<CR>
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = 'context'
"
"
function! BuildYCM(info)
   if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --go-completer --python-completer
  endif
endfunction

" Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer  --clang-tidy' }
if has('nvim')
  Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py']}
else
  Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer --clang-tidy' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

