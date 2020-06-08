set encoding=utf-8
if has('nvim')
  let s:config_home = stdpath('config')
else
  let s:config_home = '~/.config/nvim'
endif

" Set python/ruby interpreter path

if has('mac')
  let s:brew_prefix = '/usr/local'
elseif executable('brew')
  let s:brew_prefix = systemlist('brew --prefix')[0]
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

Plug 'Chiel92/vim-autoformat'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" superTab: Perform all your vim insert mode completions with Tab
" Plug 'ervandew/supertab'

" On-demand loading
" clap replace nerd tree
Plug 'liuchengxu/vim-clap'

Plug 'ryanoasis/vim-devicons'

"if can use  coc-explorer + coc-git " coc 
" Plug 'Shougo/defx.nvim' "file explorer , 
" Plug 'kristijanhusak/defx-git'
" Plug 'kristijanhusak/defx-icons'

Plug 'liuchengxu/vista.vim'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }

Plug 'mlaursen/vim-react-snippets'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'itchyny/lightline.vim'


Plug 'voldikss/vim-floaterm'

Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" HTML 
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'

" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Plug 'rhysd/vim-clang-format'  "use vim-auto-format
" Using a non-master branch

Plug 'vim-scripts/indentpython.vim', { 'for': ['py'] }


" Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer  --clang-tidy' }
if has('nvim')
  Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py']}
else
  Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer --clang-tidy' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'rdnetto/YCM-Generator', { 'for': ['c', 'cpp', 'py'] , 'branch': 'stable' }

" theme
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'hardcoreplayers/oceanic-material'
Plug 'mhartington/oceanic-next'
Plug 'jacoborus/tender.vim'
Plug 'haishanh/night-owl.vim'
Plug 'crusoexia/vim-monokai'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'liuchengxu/space-vim-theme'
Plug 'ayu-theme/ayu-vim'
Plug 'ajmwagar/vim-deus'
Plug 'flrnd/plastic.vim'
Plug 'kaicataldo/material.vim'
Plug 'bluz71/vim-moonfly-colors'

Plug 'mhinz/vim-startify'

" 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'jiangmiao/auto-pairs'

if executable('swift')
    Plug 'keith/swift.vim'
endif


Plug 'christoomey/vim-tmux-navigator'


" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp'  "math support
Plug 'iamcco/markdown-preview.vim'
Plug 'plasticboy/vim-markdown'

"  Aligning Text with Tabular.vim  :Tabularize  or \=
Plug 'godlygeek/tabular'

" spell check
" use coc-spell-check
" spell popup a good example of add popup in coc
" Plug 'kamykn/spelunker.vim'
" Plug 'kamykn/popup-menu.nvim'
Plug 'sedm0784/vim-you-autocorrect'

if executable('py')
    Plug 'nvie/vim-flake8'
    Plug 'zchee/deoplete-jedi'
endif

if executable('go')
    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
endif

" ale replace Plug  'neomake/neomake' " replace 'vim-syntastic/syntastic'
" Plugin outside ~/.vim/plugged with post-update hook
" use clap replace FZF
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" Plug 'Yggdroot/LeaderF'  "Clap relpace leaderF

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'Shougo/deoplete.nvim', { 'for': ['py'] , 'do': ':UpdateRemotePlugins' }

" let g:deoplete#enable_at_startup = 1
Plug 'neovim/python-client'


Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/echodoc.vim'
Plug 'tenfyzhong/CompleteParameter.vim'

Plug 'Lokaltog/vim-powerline'

Plug 'tpope/vim-fugitive'

" use coc-git to replace, coc-git does not spawn new proccess
" Plug 'mhinz/vim-signify'
" Plug 'airblade/vim-gitgutter'
" Plug 'APZelos/blamer.nvim'

" async linter
Plug 'w0rp/ale'


Plug 'HerringtonDarkholme/yats.vim' " TS Syntax 


Plug 'ludovicchabant/vim-gutentags'  "also used in eleline
"need gotags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' },
Plug 'jstemmer/gotags'
Plug 'skywind3000/gutentags_plus',

"" View and search LSP symbols, tags in Vim/NeoVim.

Plug 'zefei/vim-wintabs',
Plug 'zefei/vim-wintabs-powerline',
" also can use following plugin for tab
" Plug 'bagrat/vim-buffet'
" Plug 'ap/vim-buftabline'

Plug 'skywind3000/vim-quickui' " replace vim-preview
Plug 'kizza/actionmenu.nvim' " coc spelling popup

Plug 'liuchengxu/eleline.vim'

"Snippets
" Plug 'honza/vim-snippets' " replaced by coc-snippets

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'


Plug 'pseewald/vim-anyfold'   " function folding


Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'simnalamburt/vim-mundo'
"Rainbow Parentheses Improved"
Plug 'luochen1990/rainbow'
" Show color
Plug 'norcalli/nvim-colorizer.lua'

" display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
Plug 'mtdl9/vim-log-highlighting'


" highlight current session
Plug 'junegunn/Limelight.vim'
" highlight current word
Plug 'lfv89/vim-interestingwords'

Plug 'roxma/vim-hug-neovim-rpc'
" Add plugins to &runtimepath
call plug#end()


autocmd StdinReadPre * let s:std_in=1


""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
" set ttyfast                     " Indicate fast terminal conn for faster redraw
" set ttymouse=xterm2             " Indicate terminal type for mouse codes
" set ttyscroll=3                 " Speedup scrolling
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
" set noshowmatch                 " Do not show matching brackets by flickering
" set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " (turn off to speeds up highlighting)
set nocursorline                " (turn off speeds up highlighting)
set lazyredraw                  " Wait to redraw

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" list of files use two space as tab
autocmd FileType javascript,vim setlocal ts=2 sts=2 sw=2

" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
syntax on
set fdm=syntax
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt5

syntax on
set updatetime=300 "Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0

 " yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
augroup END


" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif


""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Act like D and C
nnoremap Y y$

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" let g:ctrlp_user_command = 'find %s -type f'
" ctrlp
"  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']




"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""


let g:deoplete#enable_at_startup = 0
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
let g:go_list_type = "quickfix"
let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1

" better key bindings for UltiSnipsExpandTrigger

" works on mac but not on konsole
let g:UltiSnipsExpandTrigger="<c-]>"        "default <tab> need to map to coc"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:SuperTabCrMapping=1

set mouse=a
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" paste and copy
"
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_

" Paste with middle mouse click
vmap <LeftRelease> "*ygv

" Paste with <Shift> + <Insert>
imap <C-V> <C-R>*
imap <M-V> <C-R>+   " for mac

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P


" Tab
map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>c <Plug>(wintabs_close)
map <C-T>u <Plug>(wintabs_undo)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

" CompleteParameter.vim
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

"" Python
au BufNewFile,BufRead *.py set colorcolumn=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py setlocal foldmethod=indent
au BufNewFile,BufRead *.py vmap <CR> :s/\(^\s*\)/\1# /<CR>:let @/ = ""<CR>
au BufNewFile,BufRead *.py vmap <S-CR> :s/\(^\s*\)# /\1/<CR>:let @/ = ""<CR>


"" Javascript
let javascript_enable_domhtmlcss = 1


"" Rooter
" let g:rooter_change_directory_for_non_project_files = 'home'
" let g:rooter_targets = '/,*.yml,*.yaml'
" let g:rooter_patterns = ['Rakefile', '.git/','go.sum']
" let g:rooter_use_lcd = 1
" let g:rooter_resolve_links = 1


" Load other vim
" execute 'source' fnameescape(s:config_home . '/keymap.vim')

for s:f in split(glob(s:config_home . '/pluginrc.d/*.vim'), '\n')
  execute 'source' fnameescape(s:f)
endfor

"  fold
set foldmethod=syntax
set foldlevel=10


" colorizer
if has('nvim')
lua require 'colorizer'.setup()
endif

" gutentags
let $DATA_PATH =
  \ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache') . '/vim')

let g:gutentags_cache_dir = $DATA_PATH.'/tags'
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project','go.mod','/usr/local']
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_exclude_filetypes = [ 'defx', 'denite', 'vista', 'magit' ]
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
let g:gutentags_ctags_exclude = ['*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor']


map <S-F3> :Vista!!<CR>

if !has('nvim')
  " vimspector support, it does work with neovim
  let g:vimspector_enable_mappings = 'HUMAN'
  packadd! vimspector
endif

" markdown disable conceal when edit current line
set concealcursor="i"

" ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_go_gopls_executable = 'gopls'
let g:ale_go_revive_executable = 'revive'
let g:ale_go_golangci_lint_options = '--enable-all --disable dogsled --disable gochecknoglobals --disable gochecknoinits --disable gocognit --disable godot --disable godox --disable goprintffuncname --disable lll --disable nestif --disable wsl --disable golint --disable gocyclo --disable asciicheck'
let g:ale_go_golangci_lint_package=1
" golangci-lint will run on vim-go
let g:ale_lint_delay = 1000
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'javascript.jsx': ['eslint', 'flow-language-server'],
\   'go': ['revive', 'staticcheck', 'golangci-lint', 'go vet', 'goimports', 'gotype'],
\}

let g:ale_fixers = {
\   'go': ['goimports', 'gofmt'],
\   'javascript': ['prettier', 'eslint'],
\   'javascript.jsx': ['prettier', 'eslint'],
\   'typescript': ['eslint', 'tslint'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'php': ['php-cs-fixer'],
\}


" spell
"  Zg/Zug add word; Zw/Zuw  -> to spell file
" ZG/ZUG ZW ZUW" ->to internal word list
" Zl check spell suggestion
" ZN/ZP jump between
" let g:enable_spelunker_vim = 1
" let g:spelunker_target_min_char_len = 5
" let g:spelunker_check_type=2
" let g:spelunker_highlight_type = 2  "ighlight only SpellBad.
" let g:spelunker_disable_uri_checking = 1 "def 0
" let g:vim_you_autocorrect_disable_highlighting = 1



nmap <leader>ft :FloatermNew <CR>

""""""""Folding
" " zo, zO, zc, za, ... to fold / unfold folds
" [[ and ]] to navigate ]k and [j
autocmd Filetype * AnyFoldActivate               " activate for all filetypes
autocmd Filetype cpp set foldignore=#/

let g:anyfold_identify_comments=2
let g:anyfold_fold_comments=1

" disable anyfold for large files
let g:LargeFile = 1000000 " file is large if size greater than 1MB
autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd! " remove AnyFoldActivate
        autocmd Filetype <filetype> setlocal foldmethod=indent " fall back to indent folding
    augroup END
endfunction

