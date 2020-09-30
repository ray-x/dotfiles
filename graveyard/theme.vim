
" Colorscheme
syntax enable
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark


" :set cursorline cursorcolumn

set cursorcolumn  " for code alignment and indentation

" nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" indent indicator

" set list lcs=tab:\\
" set list listchars=tab:\|\-
let g:indentLine_color_gui = '#34453E'
let g:indentLine_color_dark = 1 " (default: 2)
"let g:indentLine_bgcolor_gui = '#1B2B34'  " use hi Normal to check the bg
let g:indentLine_char_list = ['|', '¦', '┆', '┊', '']
let g:indentLine_enabled = 1

colorscheme paleaurora
"colorscheme palenight



" eleline
set laststatus=2
let g:eleline_powerline_fonts = 1
let g:airline_powerline_fonts = 1 "backword compatbilitylet

" g:interestingWordsGUIColors please refer to interestingword.vim"

" hi Folded guifg=#7CA790 gui=BOLD ctermfg=234
" hi Search guibg=#3E3F1E guifg=#C4C5AE gui=bold



""""""""""""""""""""""""""""""""
"""""  Plugin Specific color """
""""""""""""""""""""""""""""""""

hi ALEErrorSign guifg=#ECC730 ctermfg=178

" spell
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#aea03e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

"rainbow prentheses"
"let g:rainbow_active = 1


" colorizer
if has('nvim')
  lua require 'colorizer'.setup()
  lua require'terminal'.setup()
endif


"
"" Programming setup
"" Some of the theme do not have following highlight setup

" Scrollbar "
highlight link Scrollbar Comment
let g:sb_default_behavior="never"
let g:sb_bar_style = "solid"


let g:interestingWordsCycleColors = 1
let s:interestingWordsGUIColors = ['#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b', '#F92772', '#A6E22D', '#66d9ef','#E6DB74', '#FD9720', '#ae81ff', '#e73c50', '#ff0000', '#5f0000']


augroup ToggleSearchHighlighting
  autocmd!
  autocmd InsertEnter * setlocal nohlsearch
augroup END

augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 2000)
augroup END

let g:scrollbar_max_size = 5
let g:scrollbar_min_size = 1
let g:scrollbar_right_offset = 0
let g:scrollbar_excluded_filetypes = ['defx', 'vista', 'vim-startify']

let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = '﫧'
let g:gitgutter_sign_removed_first_line = '﫧'
let g:gitgutter_sign_removed_above_and_below = '﫧'
let g:gitgutter_sign_modified_removed = ''

" let g:buffet_always_show_tabline = 0
" let g:buffet_powerline_separators = 1
" let g:buffet_tab_icon = "\uf00a"
" let g:buffet_left_trunc_icon = "\uf0a8"
" let g:buffet_right_trunc_icon = "\uf0a9"

function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#16a9dc guifg=#202030
  hi! BuffetActiveBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#4f4a54 guifg=#ddd0f4
  hi! BuffetBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#2f233e guifg=#8d8094
  hi! BuffetModCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#67d5b5 guifg=#202030
  hi! BuffetModActiveBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#76715E guifg=#8d809f
  hi! BuffetModBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#76715E guifg=#8d809f
  hi! BuffetTab cterm=NONE ctermbg=5 ctermfg=8 guibg=#6690c4 guifg=#ddd0f4
endfunction"
