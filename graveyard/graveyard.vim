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