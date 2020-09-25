
" Colorscheme
syntax enable
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
let s:base02={ "gui": "#4f5b66", "cterm": "252"}
let s:base03={ "gui": "#65737e", "cterm": "250"}
let s:base04={ "gui": "#a7adba", "cterm": "234"}
let s:base08={ "gui": "#ec5f67", "cterm": "235"}
let s:base09={ "gui": "#f99157", "cterm": "252"}
let s:base0A={ "gui": "#fac863", "cterm": "250"}
let s:base0B={ "gui": "#99c794", "cterm": "234"}
let s:base0C={ "gui": "#62b3b2", "cterm": "235"}
let s:base0D={ "gui": "#6699cc", "cterm": "235"}
let s:base0E={ "gui": "#c594c5", "cterm": "235"}
let s:base0F={ "gui": "#ab7967", "cterm": "235"}


let s:white       = { "gui": "#E8E8E3", "cterm": "252" }
let s:white2      = { "gui": "#d8d8d3", "cterm": "250" }
let s:black       = { "gui": "#272822", "cterm": "234" }
let s:lightblack  = { "gui": "#2D2E27", "cterm": "235" }
let s:lightblack2 = { "gui": "#383a3e", "cterm": "236" }
let s:lightblack3 = { "gui": "#3f4145", "cterm": "237" }
let s:darkblack   = { "gui": "#211F1C", "cterm": "233" }
let s:grey        = { "gui": "#8F908A", "cterm": "243" }
let s:lightgrey   = { "gui": "#575b61", "cterm": "237" }
let s:darkgrey    = { "gui": "#64645e", "cterm": "239" }
let s:warmgrey    = { "gui": "#75715E", "cterm": "59" }

let s:pink        = { "gui": "#F92772", "cterm": "197" }
let s:green       = { "gui": "#A6E22D", "cterm": "148" }
let s:aqua        = { "gui": "#66d9ef", "cterm": "81" }
let s:yellow      = { "gui": "#E6DB74", "cterm": "186" }
let s:orange      = { "gui": "#FD9720", "cterm": "208" }
let s:purple      = { "gui": "#ae81ff", "cterm": "141" }
let s:red         = { "gui": "#e73c50", "cterm": "196" }
let s:purered     = { "gui": "#ff0000", "cterm": "52" }
let s:darkred     = { "gui": "#5f0000", "cterm": "52" }

let s:addfg       = { "gui": "#d7ffaf", "cterm": "193" }
let s:addbg       = { "gui": "#5f875f", "cterm": "65" }
let s:delbg       = { "gui": "#f75f5f", "cterm": "167" }
let s:changefg    = { "gui": "#d7d7ff", "cterm": "189" }
let s:changebg    = { "gui": "#5f5f87", "cterm": "60" }

let s:cyan        = { "gui": "#A1EFE4", "cterm": "12" }
let s:br_green    = { "gui": "#9EC400", "cterm": "32" }
let s:br_yellow   = { "gui": "#E7C547", "cterm": "145" }
let s:br_blue     = { "gui": "#7AA6DA", "cterm": "37" }
let s:br_purple   = { "gui": "#B77EE0", "cterm": "59" }
let s:br_cyan     = { "gui": "#54CED6", "cterm": "232" }
let s:br_white    = { "gui": "#FFFFFF", "cterm": "29" }
let s:background  = { "gui": "#282C34", "cterm": "235"}



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



""" one dark setup """
"let g:onedark_terminal_italics = 1
"
"
"if (has("autocmd"))
"  augroup colorextend
"    autocmd!
"    " Make `Function`s bold in GUI mode
"    autocmd ColorScheme * call onedark#extend_highlight("Function", { "gui": "bold"  })
"    " Override the `Statement` foreground color in 256-color mode
"    autocmd ColorScheme * call onedark#extend_highlight("Statement", { "fg": { " cterm": 128 } })
"    " Override the `Identifier` background color in GUI mode
"   " autocmd ColorScheme * call onedark#set_highlight("Identifier", { "bg": { " guifg": "#333333" } })
"
"   " autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:cyan })
"   autocmd ColorScheme * call onedark#set_highlight("goParen", { "fg": s:darkred })
"   autocmd ColorScheme * call onedark#set_highlight("goBlock", { "fg": s:warmgrey})
"   autocmd ColorScheme * call onedark#set_highlight("goParamName", { "fg":s:br_cyan })
"   autocmd ColorScheme * call onedark#set_highlight("goParamType", { "fg":s:addfg  })
"   autocmd ColorScheme * call onedark#set_highlight("goReceiverVar", { "fg":s:br_cyan })
"   autocmd ColorScheme * call onedark#set_highlight("goVarArgs", { "fg":s:addfg  })
"   autocmd ColorScheme * call onedark#set_highlight("goPointerOperator", { "fg":s:br_cyan })
"   autocmd ColorScheme * call onedark#set_highlight("goReceiver", { "fg":s:addfg  })
"  augroup END
"endif
"
"
"let g:onedark_color_overrides = {
"\ "black": {"gui": "#171525", "cterm": "235", "cterm16": "0" }
"\}
"
"colorscheme onedark
"" one dark cursor setup
" hi CursorLine   guifg=NONE        guibg=#151023
" hi CursorColumn guifg=NONE        guibg=#141023
" hi DiffChange gui=NONE guifg=yellow3
" hi DiffAdd guibg=NONE guifg=green4

colorscheme paleaurora

" let g:one_allow_italics = 1
" colorscheme one
" set background=dark
"" one#highlight(group, fg, bg, attribute)
" call one#highlight('goParen', 'cccccc', '', 'none')
" call one#highlight('Normal', '171525', '', 'none')

" colorscheme night-owl "disabled
" let g:airline_theme='nightowl'  "eleline
" hi CursorLine   guifg=NONE        guibg=#0f1f2f
" hi CursorColumn guifg=NONE        guibg=#0f1f2f
"" " hi Normal guibg= #1B1C24
"hi DiffChange guibg=NONE guifg=yellow4

" colorscheme plastic
" hi CursorLine   guifg=NONE        guibg=#272f37
" hi CursorColumn guifg=NONE        guibg=#272f37
" hi DiffChange guibg=NONE guifg=yellow4

" let g:material_terminal_italics = 1
" let g:material_theme_style = 'palenight'
" colorscheme material

" let g:space_vim_dark_background = 230
" colorscheme space-vim-dark

" let g:gruvbox_italic=1
" colorscheme gruvbox


" let g:airline_theme='ayu'
" let g:lightline = { 'colorscheme': 'tender' }

" let ayucolor="mirage"
" colorscheme ayu   "lack language support, not configurable...
" let g:indentLine_char = '⎸'
" let g:indentLine_first_char = '│'

" light color"
" set background=light

" colorscheme PaperColor


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
" Coc specific
" highlight for search text
:hi CocCodeLens guifg=#726238
:hi def link CocHighlightText Search
:hi CocInfoSign guifg=#227f28 guibg=#262324
:hi CocHintSign guifg=#226e23 guibg=#262324
:hi def link CocHighlightText Search


" augroup indentguide
"     au!
"     au BufNewFile,BufRead *.go IndentGuidesEnable
"     au BufNewFile,BufRead *.go hi IndentGuidesOdd  guibg=red   ctermbg=3
"     au BufNewFile,BufRead *.go hi IndentGuidesEven  guibg=green   ctermbg=3
" augroup end

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


"""""" Conceal setup
let fts = ['c', 'cpp']
if index(fts, &filetype) != -1
  setlocal conceallevel=1
  syntax clear cppOperator

  syntax match cppOperator "++" conceal cchar=⧺
  syntax match cppOperator "<<" conceal cchar=«
  syntax match cppOperator ">>" conceal cchar=»
  syntax match cppOperator "::" conceal cchar=∷

  syntax match cppOperator "||" conceal cchar=∥

  hi! link cppOperator Operator
  hi! link Conceal Operator
endif


let fts = ['go']
if index(fts, &filetype) != -1
  setlocal conceallevel=1
  syntax clear goOperator
  syntax clear goDeclaration

  syntax match goOperator "++" conceal cchar=⧺
  syntax match goOperator "<<" conceal cchar=«
  syntax match goOperator ">>" conceal cchar=»
  syntax match goDeclaration "func" conceal cchar=
  hi! link goOperator Operator
  hi! link goDeclaration Declaration
  hi! link Conceal Operator
endif

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



let g:buffet_always_show_tabline = 0
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"

function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#16a9dc guifg=#202030
  hi! BuffetActiveBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#4f4a54 guifg=#ddd0f4
  hi! BuffetBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#2f233e guifg=#8d8094
  hi! BuffetModCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#67d5b5 guifg=#202030
  hi! BuffetModActiveBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#76715E guifg=#8d809f
  hi! BuffetModBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#76715E guifg=#8d809f
  hi! BuffetTab cterm=NONE ctermbg=5 ctermfg=8 guibg=#6690c4 guifg=#ddd0f4
endfunction"
