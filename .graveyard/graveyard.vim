""""""""""""""""""""""" Plug no longer use...""""""""""""""""""""""
" superTab: Perform all your vim insert mode completions with Tab
" Plug 'ervandew/supertab'
" if can use  coc-explorer + coc-git " coc
" Plug 'Shougo/defx.nvim' "file explorer ,
" Plug 'kristijanhusak/defx-git'
" Plug 'kristijanhusak/defx-icons'
" let g:deoplete#enable_at_startup = 1
" Plug 'neovim/python-client'
" Plug 'sickill/vim-monokai'
" Plug 'buoto/gotests-vim', { 'for': ['go'] }
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Plug 'kamykn/popup-menu.nvim'  "spell popup

" Plug 'voldikss/vim-floaterm', { 'on': ['FloatermNew'] }

set noshowmatch                 " Do not show matching brackets by flickering

if executable('swift')
  Plug 'keith/swift.vim', { 'for': ['swift'] }
endif
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter' " , { 'on': ['GitGutterBufferEnable', 'GitGutterEnable']}
Plug 'pangloss/vim-javascript'
Plug 'pseewald/vim-anyfold', { 'on': ['AnyFoldActivate']}

Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
" Javascript
" FIXME
Plug 'prettier/vim-prettier', {'do': 'yarn install','on': ['PrettierAsync', 'Prettier'] }
" Plug 'Chiel92/vim-autoformat'


" call dein#add('easymotion/vim-easymotion', {'on_map': '<Plug>'})  " Great plugin, but 1) I used mouse more, 2) conflict with lsp, 3)lots of hot key was binded,  the gain can not pay the price"
" call dein#add('tpope/vim-repeat', {'on_map': '<Plug>'}) " repead motion"

" call dein#add('iamcco/mathjax-support-for-mkdp', { 'on_ft': ['markdown']}) "math support


Plug 'mlaursen/vim-react-snippets'
Plug 'UltiSnips'
Plug 'groenewege/vim-less', { 'for': ['html','css'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['html','css', 'js', 'ts', 'tsx'] }
" FIXME
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'branch': 'release/1.x',
"   \ 'for': [
"     \ 'css',
"     \ 'less',
"     \ 'scss',
"     \ 'json',
"     \ 'graphql',
"     \ 'markdown',
"     \ 'html',
"     \ 'swift' ],
"   \ 'on': ['PrettierAsync', 'Prettier'] }
" Plug 'hail2u/vim-css3-syntax'
" Plug 'tpope/vim-surround'  "Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. 
" Plug 'othree/html5.vim'

" spell check
" use coc-spell-check
" spell popup a good example of add popup in coc
" Plug 'kamykn/spelunker.vim'
" Plug 'kamykn/popup-menu.nvim'  "spell popup
" Snippets
" Plug 'honza/vim-snippets' " replaced by coc-snippets
" 自动补全括号的插件，包括小括号，中括号，以及花括号 coc-pair
" Plug 'jiangmiao/auto-pairs'
Plug 'rdnetto/YCM-Generator', { 'for': ['c', 'cpp', 'py'] , 'branch': 'stable' }
" Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer  --clang-tidy' }
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py']}
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer --clang-tidy' }
" autocomplete path, yank etc
let g:deoplete#enable_at_startup = 1
" Plug 'tenfyzhong/CompleteParameter.vim'  " do not work with nvim-lsp"
Plug 'christoomey/vim-tmux-navigator'
Plug 'EchoDoc'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'sedm0784/vim-you-autocorrect'   "autocmd BufEnter * EnableAutocorrect

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

Plug 'skywind3000/vim-quickui' " replace vim-preview

" highlight current session
Plug 'junegunn/Limelight.vim' " never used sofar

" python highlight
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'py' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp']}  "C++ 11/14

if has('nvim')
  " highlight with treesitter
  Plug 'nvim-treesitter/nvim-treesitter'
else
  Plug 'govim/govim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" COC used to be my favourite"
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'vn-ki/coc-clap'

" Plug 'zefei/vim-wintabs',
" Plug 'zefei/vim-wintabs-powerline',
" also can use vim-buffet/buftabline plugin for tab

" Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }  "file explorer ,
" Plug 'kristijanhusak/defx-git'
" Plug 'kristijanhusak/defx-icons'

""""""""""" theme not so good """""""""""
" Plug 'morhetz/gruvbox'.  "warm color, not my cup of tea, but it is very popular"
" Plug 'ajmwagar/vim-deus'    "green + yellow similar to oceanic material"
" Plug 'ayu-theme/ayu-vim'   "lack language support
" Plug 'rakr/vim-one' Similar to one, also slow....
" Plug 'haishanh/night-owl.vim'  "nice, but can not configure...
" Plug 'drewtempelmeyer/palenight.vim'  " similar to material-pale
" Plug 'jacoborus/tender.vim'   " not much support for go
" Plug 'bluz71/vim-moonfly-colors'  " good golang support, color is plain...
" Plug 'mhartington/oceanic-next'  "no go support, need relay on polygot, not configurable
" Plug 'hardcoreplayers/oceanic-material'  "good language support, similar to material-oceanic, not much star/updates
" Plug 'crusoexia/vim-monokai'. " no go support... keep it because it is one of the classic
" Plug 'flrnd/plastic.vim'
" Plug 'dracula/vim'

" Plug 'drewtempelmeyer/palenight.vim'
Plug 'kyazdani42/nvim-palenight.lua'
" Plug 'joshdick/onedark.vim'
" Plug 'haishanh/night-owl.vim'  "nice, but can not configure...
" Plug 'liuchengxu/space-vim-dark'    " blue style
" Plug 'kaicataldo/material.vim'
" Plug 'NLKNguyen/papercolor-theme'     "" one will need at least a light color, ayu-vim light is another option
" Plug 'morhetz/gruvbox'

" Plug 'liuchengxu/eleline.vim'

" Plug 'fenetikm/falcon'

if executable('py')
    Plug 'nvie/vim-flake8', { 'for': 'py' }  "ALE"
endif

""""""""""""""""""""""" Plug no longer use...""""""""""""""""""""""


" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt5

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0

" print filename when load
" autocmd BufEnter * silent! lcd %:p:h

"" Rooter airblade/vim-rooter  Rooter changes the working directory to the project root when you open a file or directory.
" let g:rooter_change_directory_for_non_project_files = 'home'
" let g:rooter_targets = '/,*.yml,*.yaml'
" let g:rooter_patterns = ['Rakefile', '.git/','go.sum']
" let g:rooter_use_lcd = 1
" let g:rooter_resolve_links = 1

" Plug 'ludovicchabant/vim-gutentags'  "also used in eleline
" need gotags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' },
Plug 'jstemmer/gotags'
Plug 'skywind3000/gutentags_plus', { 'for': ['c', 'cpp']}


coc-go
" Build/Test on save.  Note: GoImports/GoFmt will cleanup error signs from coc

augroup auto_go
  autocmd!
  " autocmd BufWritePost *.go :AsyncRun -cwd=%:p:h go vet .
  " autocmd BufWritePost *.go :AsyncRun -cwd=%:p:h golangci-lint run
  " autocmd BufWritePost *.go :Neomake | lopen 3
  " autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd BufWritePre *.go lua vim.lsp.buf.code_action({ source = { organizeImports = true } })
  autocmd BufWritePre *.go :Format
  autocmd BufWriteCmd *.mod :GoModFmt
  autocmd BufWritePost *.mod :AsyncRun -cwd=<root> go mod tidy
  " autocmd BufWritePost *_test.go :AsyncRun -raw -cwd=%:p:h go test ./... -tags=integration | lopen 3
augroup end


" CompleteParameter.vim
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)


" ale is good enough
let g:neomake_go_enabled_makers = [ 'golangci_lint', 'go' ]
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" nnoremap <Leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
" nnoremap <Leader>P <cmd>lua require'telescope.builtin'.find_files{}<CR>
" nnoremap <silent> <Leader>Ff <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/.config/nvim/" }<CR>


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']

map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>c <Plug>(wintabs_close)
map <C-T>u <Plug>(wintabs_undo)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab


" let g:neomake_go_enabled_makers = [ 'golangci_lint', 'go' ]
" let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
" let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
" let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
" let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
"  fold
" set foldmethod=syntax
" set foldlevel=10


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

" Coc specific
" highlight for search text
:hi CocCodeLens guifg=#726238
:hi def link CocHighlightText Search
:hi CocInfoSign guifg=#227f28 guibg=#262324
:hi CocHintSign guifg=#226e23 guibg=#262324
:hi def link CocHighlightText Search


" better key bindings for UltiSnipsExpandTrigger

" works on mac but not on konsole
let g:UltiSnipsExpandTrigger="<c-]>"        "default <tab> need to map to coc"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:SuperTabCrMapping=1
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


if !has('nvim')
  " vimspector support, it does work with neovim
  " let g:vimspector_enable_mappings = 'HUMAN'
  " packadd! vimspector
endif


lua require('bufferline').setup{
\  options = {
\    view = "multiwindow",
\    numbers = "ordinal",
\    mappings = true,
\    max_name_length = 16,
\    tab_size = 16,
\    separator_style = "thin",
\    always_show_bufferline = false,
\  },
\ }

lua <<EOF
-- totally optional to use setup
require('telescope').setup{
  defaults = {
    shorten_path = false -- currently the default value is true
  }
}
EOF

nnoremap <Leader>p <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <silent> gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap <Leader>en <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/.config/nvim/" }<CR>
