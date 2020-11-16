let g:clap_layout = {'relative': 'editor', 'width': '71%', 'height': '39%', 'row': '13%', 'col': '10%' }
let g:clap_preview_size = 10  "" def: 5
let g:airline_powerline_fonts = 1
let g:clap_search_box_border_symbols = { 'arrow': ["\ue0b2", "\ue0b0"], 'curve': ["\ue0b6", "\ue0b4"], 'nil': ['', '']     }

set laststatus=2
let g:clap_popup_border = "rounded"

nmap <F4> :Clap<CR>
noremap <leader><s-c>p :Clap proj_tags <CR>
" \<s-p> not work well because some time it copy into text

noremap <leader><s-F> :Clap grep ++query=<cword><CR>
cmap <leader><S-F>h :Clap command_history<CR>
noremap <leader>ch :Clap command_history<CR>
noremap <leader>cf :Clap history<CR>

function! s:history(arg)
  let l:query=''
  let l:subcommand=''
  echo a:arg
  if len(a:arg) > 0
  	let l:query=' ++query='+a:arg[1]
  endif

  if a:arg[0] == ':'
    let l:subcommand = 'command_history'
    let l:query=trim(a:arg[1:])
  elseif a:arg[0] == '/'
    let l:subcommand = 'search_history'
    let l:query=trim(a:arg[1:])
  else
    let l:subcommand = 'history'
    let l:query=trim(a:arg)
  endif

  if len(l:query) > 1
    let l:query=' ++query=' . l:query
  endif
  exec 'Clap '. l:subcommand . l:query
endfunction

" noremap <c-F>:Clap grep2 ++query=@visual<CR>
noremap <s-T> :Clap tags<CR>
nmap <S-F3> :Clap filer<CR>

nmap <c-E> :Clap filer<CR>

" let g:clap_theme = 'atom_dark'
let g:clap_selected_sign = { 'text': '', 'texthl': "ClapSelectedSign", "linehl": "ClapSelected" }
let g:clap_current_selection_sign = { 'text': '', 'texthl': "ClapCurrentSelectionSign", "linehl":     "ClapCurrentSelection" }


finish
command! -bang -nargs=* History call s:history(<q-args>)
" command! Files :Clap files  "cmd-p"
command! Buffers :Clap buffers
command! Tags :Clap proj_tags
command! Buffers :Clap buffers
command! Commits :Clap commits
command! Cdiff :Clap git_diff_files
command! Jumps :Clap jumps
command! Yanks :Clap yanks
command! Windows :Clap windows
command! Ag :Clap grep ++query<cword>
command! Ag2 :Clap grep2 ++query<cword>


command! -nargs=0 His :Clap history
command! -nargs=0 Ch :Clap command_history
command! -nargs=0 Sh :Clap search_history
