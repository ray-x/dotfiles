"" Clap


let g:clap_layout = {'width': '47%', 'height': '43%', 'row': '43%', 'col': '17%' }
" let g:clap_open_action = { 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
set laststatus=2
" export TERM=xterm-256color
" if !has('gui_running')
"   set t_Co=256
" endif

nmap <F4> :Clap<CR>

noremap <s-P> :Clap files<CR>
noremap <s-F> :Clap grep ++query=<cword><CR>

" noremap <c-F>:Clap grep ++query=@visual<CR>
noremap <s-T> :Clap tags<CR>
nmap <S-F2> :Clap filer<CR>

command! -nargs=0 His :Clap history
command! -nargs=0 Ch :Clap command_history
command! -nargs=0 Sh :Clap search_history

" let g:clap_theme = 'material_design_dark'

hi default link ClapProjTagPattern String
