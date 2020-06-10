"" Clap


let g:clap_layout = {'relative': 'editor', 'width': '77%', 'height': '33%', 'row': '12%', 'col': '10%' }
let g:clap_preview_size = 12  "" def: 5
let g:airline_powerline_fonts = 1
let g:clap_search_box_border_symbols = { 'arrow': ["\ue0b2", "\ue0b0"], 'curve': ["\ue0b6", "\ue0b4"], 'nil': ['', ''] }


" let g:clap_open_action = { 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
set laststatus=2
let g:clap_popup_border = "rounded"

nmap <F4> :Clap<CR>
noremap <leader><s-c>p :Clap proj_tag <CR>
noremap <leader><s-P> :Clap files<CR>

noremap <leader><s-F> :Clap grep2 ++query=<cword><CR>
cmap <leader><S-F>h :Clap command_history<CR>
noremap <leader>ch :Clap command_history<CR>
noremap <leader>cf :Clap history<CR>


" noremap <s-F> :Clap grep2 ++query=<cword><CR>
" noremap <c-F>:Clap grep2 ++query=@visual<CR>
noremap <s-T> :Clap tags<CR>
nmap <S-F2> :Clap filer<CR>

command! -nargs=0 His :Clap history
command! -nargs=0 Ch :Clap command_history
command! -nargs=0 Sh :Clap search_history

let g:clap_theme = 'material_design_dark'
let g:clap_selected_sign = { 'text': '', 'texthl': "ClapSelectedSign", "linehl": "ClapSelected" }
let g:clap_current_selection_sign = { 'text': '', 'texthl': "ClapCurrentSelectionSign", "linehl": "ClapCurrentSelection" }
