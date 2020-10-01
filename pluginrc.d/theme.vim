
" Colorscheme
" syntax enable
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set background=dark
colorscheme paleaurora

" :set cursorline cursorcolumn

set cursorcolumn  " for code alignment and indentation

" nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" colorscheme paleaurora

" eleline
set laststatus=2
let g:eleline_powerline_fonts = 1
let g:airline_powerline_fonts = 1 "backword compatbilitylet


""""""""""""""""""""""""""""""""
"""""  Plugin Specific color """
""""""""""""""""""""""""""""""""

" spell
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#aea03e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

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

let g:scrollbar_max_size = 6
let g:scrollbar_min_size = 2
let g:scrollbar_right_offset = 0
let g:scrollbar_excluded_filetypes = ['defx', 'vista', 'vista_kind', 'vim-startify', 'LuaTree']


let g:signify_sign_add = ''
let g:signify_sign_delete = '﫧'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = ''
let g:signify_sign_show_count = 5
