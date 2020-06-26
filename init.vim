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

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'Chiel92/vim-autoformat'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'ryanoasis/vim-devicons'

Plug 'liuchengxu/vista.vim'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
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

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim'

Plug 'mlaursen/vim-react-snippets'

Plug 'voldikss/vim-floaterm'

Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" language support
Plug 'sheerun/vim-polyglot'  " incase the language is not well defined in syntax use this plugin"
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp']}  "C++ 11/14
Plug 'lifepillar/pgsql.vim'

" HTML
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'

Plug 'vim-scripts/indentpython.vim', { 'for': 'py' }

Plug 'preservim/nerdcommenter'  " add comments to code, 
" tomtom/tcomment_vim is another alternative

" Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer  --clang-tidy' }
if has('nvim')
  Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py']}
else
  Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'py'],  'do': './install.py  --clangd-completer --clang-tidy' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'rdnetto/YCM-Generator', { 'for': ['c', 'cpp', 'py'] , 'branch': 'stable' }

Plug 'mhinz/vim-startify'

" theme
Plug 'ray-x/paleaurora'
Plug 'joshdick/onedark.vim'
Plug 'haishanh/night-owl.vim'  "nice, but can not configure...
Plug 'liuchengxu/space-vim-dark'    " blue style
Plug 'kaicataldo/material.vim'
Plug 'NLKNguyen/papercolor-theme'     "" one will need at least a light color, ayu-vim light is another option
Plug 'morhetz/gruvbox'
Plug 'fenetikm/falcon'


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

Plug 'sedm0784/vim-you-autocorrect'

if executable('py')
    Plug 'nvie/vim-flake8'
    Plug 'zchee/deoplete-jedi'
endif

Plug 'fatih/vim-go', { 'for': ['go'] , 'do': ':GoInstallBinaries' }

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vn-ki/coc-clap'

Plug 'Shougo/deoplete.nvim', { 'for': ['py'] , 'do': ':UpdateRemotePlugins' }

" asynchronous supprot or vim"
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/echodoc.vim'
Plug 'tenfyzhong/CompleteParameter.vim'

Plug 'Lokaltog/vim-powerline'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'  "git commit browser. :GV(!|?) move: ]]/ [[

" async linter
Plug 'w0rp/ale'
" Plug 'vim-syntastic/syntastic'

Plug 'HerringtonDarkholme/yats.vim' " TS Syntax


Plug 'ludovicchabant/vim-gutentags'  "also used in eleline
"need gotags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' },
Plug 'jstemmer/gotags'
Plug 'skywind3000/gutentags_plus', { 'for': ['c', 'cpp']}

Plug 'vim-test/vim-test'
Plug 'neomake/neomake'

Plug 'zefei/vim-wintabs',
Plug 'zefei/vim-wintabs-powerline',
" also can use vim-buffet/buftabline plugin for tab

Plug 'skywind3000/vim-quickui' " replace vim-preview

Plug 'liuchengxu/eleline.vim'
" Motion
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat' " repead motion"
Plug 'bkad/CamelCaseMotion'

Plug 'pseewald/vim-anyfold'   " function folding

Plug 'liuchengxu/vim-clap'   " keep the binary for a while. download and rebuild took time
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

Plug 'simnalamburt/vim-mundo'

"Rainbow Parentheses Improved"
Plug 'luochen1990/rainbow'

" Show color
Plug 'norcalli/nvim-colorizer.lua'

" for pager
Plug 'norcalli/nvim-terminal.lua'

" display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
Plug 'mtdl9/vim-log-highlighting'
if has('nvim')
    Plug 'sslivkoff/vim-scroll-barnacle', { 'on': 'ScrollbarOff' },
endif
" highlight current session
Plug 'junegunn/Limelight.vim'
" highlight current word
Plug 'ray-x/vim-interestingwords'

Plug 'roxma/vim-hug-neovim-rpc'
" Add plugins to &runtimepath

call plug#end()


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
" spell check
" use coc-spell-check
" spell popup a good example of add popup in coc
" Plug 'kamykn/spelunker.vim'
" Plug 'kamykn/popup-menu.nvim'  "spell popup
" Snippets
" Plug 'honza/vim-snippets' " replaced by coc-snippets
" 自动补全括号的插件，包括小括号，中括号，以及花括号 coc-pair
" Plug 'jiangmiao/auto-pairs'



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



autocmd StdinReadPre * let s:std_in=1


""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
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
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=12                " Completion window max size
" set nocursorcolumn              " (turn off to speeds up highlighting)
set nocursorline                " (turn off speeds up highlighting)
set lazyredraw                  " Wait to redraw
set autoread                    " Automatically read changed files
au FocusGained,BufEnter * :checktime  " autoload



if !has('nvim')
  set ttyscroll=3                 " Speedup scrolling
  set ttymouse=xterm2
endif
if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-n>
endif

" file hidden
set wildmenu
set wildmode=longest:full,full
set wildignore+=**/node_modules/**,/node_modules/*,*/tmp/*,*.so,*.swp,*.zip
if has('nvim')
  set wildoptions=pum
endif

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

set numberwidth=3
set cpoptions+=n                " use the number column for the text of wrapped lines

" list of files use two space as tab
autocmd FileType javascript,vim,yml,markdown setlocal ts=2 sts=2 sw=2

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
" if setup up <S-fn> for terminal, please refer to kitty.conf
" use terminfo-x / cat to show the special key combinations
" Extensions to the xterm protocol: https://sw.kovidgoyal.net/kitty/protocol-extensions.html 
" vim or nvim
if !has("gui_running")
  if !has('nvim')
    set <S-F1>=^[[1;2P
    map <Esc>[1;2P <S-F1>
    set <S-F2>=^[[1;2Q
    map <Esc>[1;2Q <S-F2>
    set <S-F3>=^[[1;2R
    map <Esc>[1;2R <S-F3>
  else
    map <F13> <S-F1>
    map <F14> <S-F4>
    map <F15> <S-F5>
    map <F16> <S-F6>
  endif
endif

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
set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.ist,*/.fdb_latexmk,**/tmp/**,*/.so,*/.swp,*/.zip,*/.o

" set grepprg=rg\ --vimgrep    " set grepprg=ag\ --vimgrep\ $*
" Ggrep only search files under git control
set grepprg=git\ --no-pager\ grep\ --no-color\ -n\ $*
set grepformat=%f:%l:%m,%m\ %f\ match%ts,%f


"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

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



"  fold
set foldmethod=syntax
set foldlevel=10


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


map <F3> :Vista!!<CR>

if !has('nvim')
  " vimspector support, it does work with neovim
  " let g:vimspector_enable_mappings = 'HUMAN'
  " packadd! vimspector
endif

" markdown disable conceal when edit current line
set concealcursor="i"

nmap <leader>ft :FloatermNew <CR>

""""""""Folding
autocmd Filetype * AnyFoldActivate               " activate for all filetypes
autocmd Filetype cpp set foldignore=#/

let g:anyfold_identify_comments=2
let g:anyfold_fold_comments=1

autocmd Filetype cpp let g:cpp_class_scope_highlight = 1
autocmd Filetype cpp let g:cpp_member_variable_highlight = 1
autocmd Filetype cpp let g:cpp_class_decl_highlight = 1
autocmd Filetype cpp let g:cpp_posix_standard = 1
autocmd Filetype cpp let g:cpp_experimental_simple_template_highlight = 1
autocmd Filetype cpp let g:cpp_experimental_template_highlight = 1
autocmd Filetype cpp let g:cpp_concepts_highlight = 1

" disable anyfold for large files
let g:LargeFile = 1000000 " file is large if size greater than 1MB
autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd! " remove AnyFoldActivate
        autocmd Filetype <filetype> setlocal foldmethod=indent " fall back to indent folding
    augroup END
endfunction


""""""""" Load other vim plugin config """""""""
" execute 'source' fnameescape(s:config_home . '/keymap.vim')

for s:f in split(glob(s:config_home . '/pluginrc.d/*.vim'), '\n')
  execute 'source' fnameescape(s:f)
endfor


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']


let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'kitty',
  \ 'suite':   'kitty',
\}

let g:interestingWordsCycleColors = 1
let s:interestingWordsGUIColors = ['#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b', '#F92772', '#A6E22D', '#66d9ef','#E6DB74', '#FD9720', '#ae81ff', '#e73c50', '#ff0000', '#5f0000']
