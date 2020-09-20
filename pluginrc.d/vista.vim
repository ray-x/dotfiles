"" vista tag
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

let g:vista_disable_statusline = 1
" let g:vista_default_executive = 'ctags'
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_vimwiki_executive = 'markdown'
let g:vista_executive_for = {
  \ 'vimwiki': 'markdown',
  \ 'pandoc': 'markdown',
  \ 'markdown': 'toc',
  \ 'yaml': 'nvim-lsp',
  \ 'typescript': 'nvim-lsp',
  \ 'go': 'nvim-lsp',
  \ }

