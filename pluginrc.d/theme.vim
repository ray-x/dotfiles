
" Colorscheme
syntax enable
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark

:set cursorline cursorcolumn
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" indent indicator

" set list lcs=tab:\\
" set list listchars=tab:\|\-
let g:indentLine_color_gui = '#54757E'
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_bgcolor_gui = '#1B2B34'  " use hi Normal to check the bg
let g:indentLine_char_list = ['|', '¦', '┆', '┊', '']
let g:indentLine_enabled = 1

if (has("autocmd"))
   augroup colorextend
     autocmd!
     " Make `Function`s bold in GUI mode
     autocmd ColorScheme * call onedark#extend_highlight("Function", { "gui": "bold"  })
     " Override the `Statement` foreground color in 256-color mode
     autocmd ColorScheme * call onedark#extend_highlight("Statement", { "fg": { " cterm": 128 } })
     " Override the `Identifier` background color in GUI mode
     " autocmd ColorScheme * call onedark#extend_highlight("Identifier", { "bg": { " gui": "#333333" } })
   augroup END
 endif


let g:onedark_color_overrides = {
\ "black": {"gui": "#272020", "cterm": "235", "cterm16": "0" }
\}


" colorscheme monokai
" let g:monokai_term_italic = 1
" let g:monokai_gui_italic = 1

" colorscheme tender
" let g:lightline = { 'colorscheme': 'tender' }

" let g:one_allow_italics = 1
" colorscheme one

" let g:oceanic_material_enable_italic = 1
" let g:oceanic_material_transparent_background = 0
" colorscheme oceanic_material

" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" colorscheme  OceanicNext
" hi CursorLine   guifg=NONE        guibg=#20343D     gui=NONE      ctermfg=237      ctermbg=NONE        cterm=BOLD
" hi CursorColumn guifg=NONE        guibg=#20343D     gui=NONE      ctermfg=237       ctermbg=NONE        cterm=BOLD


"colorscheme night-owl
"let g:airline_theme='nightowl'  "eleline
" hi CursorLine   guifg=NONE        guibg=#222D20
" hi CursorColumn guifg=NONE        guibg=#222D2D

" colorscheme plastic

" let g:material_terminal_italics = 1
" let g:material_theme_style = 'palenight'
" colorscheme material

" colorscheme palenight
" let g:airline_theme='palenight'  "eleline


" let g:molokai_original = 1
" colorscheme molokai

" colorscheme space_vim_theme

let g:onedark_terminal_italics = 1
colorscheme onedark
hi CursorLine   guifg=NONE        guibg=#2F2727
hi CursorColumn guifg=NONE        guibg=#2F2727


" colorscheme deus

" let g:gruvbox_italic=1
" colorscheme gruvbox

" let g:airline_theme='ayu'
" let g:lightline = { 'colorscheme': 'tender' }



" let ayucolor="mirage" 
" colorscheme ayu
" let g:indentLine_char = '⎸'
" let g:indentLine_first_char = '│'
" let g:indentLine_showFirstIndentLevel = 0
" let g:indentLine_setColors = 0


" colorscheme moonfly
" highlight Normal ctermbg=232 ctermfg=251 guibg=#1b1c11  guifg=#c6c6c6

" airline
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
" spaceline
" let g:spaceline_colorscheme = 'space'

" eleline
set laststatus=2
let g:eleline_powerline_fonts = 1
let g:airline_powerline_fonts = 1 "backword compatbility


let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']


hi Folded guifg=#7CA790 gui=BOLD ctermfg=234
hi Search guibg=#3E3F1E guifg=#C4C5AE gui=bold


""""""""""""""""""""""""""""""""
"""""  Plugin Specific color """
""""""""""""""""""""""""""""""""

hi ALEErrorSign guifg=#ECC730 ctermfg=178
" Coc specific 
" highlight for search text
:hi CocCodeLens guifg=#726238
:hi def link CocHighlightText Search

" spell 
"highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#aea03e
"highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

"rainbow prentheses"
"let g:rainbow_active = 1
