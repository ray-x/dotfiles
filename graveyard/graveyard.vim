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

if executable('swift')
  Plug 'keith/swift.vim', { 'for': ['swift'] }
endif
Plug 'neomake/neomake'

Plug 'pangloss/vim-javascript'

Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'


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
