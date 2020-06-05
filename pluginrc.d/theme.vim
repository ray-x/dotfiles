" indent indicator

set list lcs=tab:\|\ 
let g:indentLine_color_gui = '#54553E'
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_bgcolor_gui = '#2B2B2B'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 1



" Colorscheme
syntax enable
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark

:set cursorline cursorcolumn
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>


if (has("autocmd"))
  augroup colorextend
    autocmd!
    " Make `Function`s bold in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("Function", { "gui": "bold" })
    " Override the `Statement` foreground color in 256-color mode
    autocmd ColorScheme * call onedark#extend_highlight("Statement", { "fg": { "cterm": 128 } })
    " Override the `Identifier` background color in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("Identifier", { "bg": { "gui": "#333333" } })
  augroup END
endif


" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
" if (has("autocmd") && !has("gui_running"))
"  augroup colorset
"    autocmd!
"    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
"    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
"  augroup END
" endif



let g:onedark_color_overrides = {
\ "black": {"gui": "#2F242F", "cterm": "235", "cterm16": "0" }
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


" colorscheme night-owl
" let g:airline_theme='nightowl'  "eleline
" hi CursorLine   guifg=NONE        guibg=#222D20
" hi CursorColumn guifg=NONE        guibg=#222D2D

" colorscheme palenight
" let g:airline_theme='palenight'  "eleline


" let g:molokai_original = 1
" colorscheme molokai

" colorscheme space_vim_theme

colorscheme onedark
let g:onedark_terminal_italics = 1
" let g:airline_theme='onedark'
let g:lightline = { 'colorscheme': 'tender' }
hi CursorLine   guifg=NONE        guibg=#38343F
hi CursorColumn guifg=NONE        guibg=#38343F


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
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#aea03e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
