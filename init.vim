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


" defx file explorer
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'  " change back to Plug 'ryanoasis/vim-devicons' when devicecons 0.14



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
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/lightline.vim'

" HTML 
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'

" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'rhysd/vim-clang-format'
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'honza/vim-snippets'

Plug 'vim-scripts/indentpython.vim'
Plug 'rakr/vim-one'
Plug 'jacoborus/tender.vim'


" 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'jiangmiao/auto-pairs'

if executable('swift')
    Plug 'keith/swift.vim'
endif

Plug 'mhinz/vim-signify'  " replace 'airblade/vim-gitgutter'

Plug 'christoomey/vim-tmux-navigator'


" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" spell check
Plug 'kamykn/spelunker.vim'
" spell popup
Plug 'kamykn/popup-menu.nvim'

if executable('py')
    Plug 'nvie/vim-flake8'
    Plug 'zchee/deoplete-jedi'
endif

if executable('go')
    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
endif


Plug 'vim-syntastic/syntastic'
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'Yggdroot/LeaderF'  "Clap relpace leaderF

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
Plug 'Yggdroot/indentLine'

" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'Shougo/deoplete.nvim', { 'for': ['py'] , 'do': ':UpdateRemotePlugins' }

" let g:deoplete#enable_at_startup = 1
Plug 'neovim/python-client'


Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/echodoc.vim'
Plug 'tenfyzhong/CompleteParameter.vim'


Plug 'tomasr/molokai'
Plug 'Lokaltog/vim-powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'

" Plug 'wincent/command-t'

Plug 'morhetz/gruvbox'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax 


Plug 'ludovicchabant/vim-gutentags'
"need gotags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' },
Plug 'jstemmer/gotags'
Plug 'skywind3000/gutentags_plus',

"" View and search LSP symbols, tags in Vim/NeoVim.
Plug 'liuchengxu/vista.vim'

Plug 'zefei/vim-wintabs',
Plug 'zefei/vim-wintabs-powerline',
"Plug 'ap/vim-buftabline'
Plug 'pboettch/vim-highlight-cursor-words'
Plug 'skywind3000/vim-preview'


"Snippets
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'honza/vim-snippets'

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

Plug 'airblade/vim-rooter'

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

" vim suppor for neovim
"
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
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
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
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
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
" colorscheme fx
" set gui not working in neovim
" set guifont=Inconsolata-g\ for\ Powerline:h12
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
" set guifont=Source\ Code\ Pro\ for\ Powerline:h12
" 
" Guifont SourceCodePro\ Nerd\ Font:h14
" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile


 " yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
augroup END

set background=dark
" colorscheme molokai
" colorscheme tender

" colorscheme tender
" let g:lightline = { 'colorscheme': 'tender' }

let g:one_allow_italics = 1
colorscheme one

set nofoldenable


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

" Colorscheme
syntax enable
" set t_Co=256
" let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme molokai
set termguicolors



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
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:SuperTabCrMapping=1

set mouse=a
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" default key map:

"<leader>cg - 查看光标下符号的定义
"<leader>cs - 查看光标下符号的引用
"<leader>cc - 查看有哪些函数调用了该函数
"<leader>cf - 查找光标下的文件
"<leader>ci - 查找哪些文件 include 了本文件
"
"
"
" source /Users/rayx/.vim/vim/asc.vim
" source /Users/rayx/.vim/vim/skywind.vim
"
" Search in project
"
function! FindProjectRoot(lookFor)
    let s:root=expand('%:p:h')
    let pathMaker='%:p'
    while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
        let pathMaker=pathMaker.':h'
        let fileToCheck=expand(pathMaker).'/'.a:lookFor
        if filereadable(fileToCheck)||isdirectory(fileToCheck)
            let s:root=expand(pathMaker)
        endif
    endwhile
    return s:root
endfunction
let g:root_dir = FindProjectRoot('.git')   " 搜索 .git 为项目路径

autocmd BufEnter * silent! lcd g:root_dir  " 设置当前路径为项目路径

"grepper
" nmap gs <plug>(GrepperOperator)	" " 选择字符后按 g + s 开始搜索（异步的）
" xmap gs <plug>(GrepperOperator)
" let g:grepper = {}
" let g:grepper.ag = {}
" let g:grepper.ag.grepprg = 'ag --vimgrep  --smart-case $* '.g:root_dir " 设置 ag 参数


let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']  " Ctrl + v 纵向分屏打开
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>'] " Enter 横向分屏打开
let g:qfenter_keymap.topen = ['t'] " 按 t 在新的标签页打开

" vim-preview
noremap <m-u> :PreviewScroll -1<cr> " Alt + u 往上滚动预览窗口
noremap <m-d> :PreviewScroll +1<cr> " Alt + d 往下滚动预览窗口
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

" 在quickfix窗口按 p 打开预览窗口（配合 grepper 插件很实用）
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
noremap <m-n> :PreviewSignature!<cr> " Alt + n 提示函数声明
inoremap <m-n> <c-\><c-o>:PreviewSignature!<cr>
noremap <leader>g :PreviewTag<cr> " leader + g " 打开单词tag的预览窗口
inoremap <leader>g <c-\><c-o>:PreviewTag<cr>


" paste and copy
"
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_

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

"" vista tag
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()



"" Rooter
let g:rooter_change_directory_for_non_project_files = 'home'
let g:rooter_targets = '/,*.yml,*.yaml'
let g:rooter_patterns = ['Rakefile', '.git/','go.sum']
let g:rooter_use_lcd = 1
let g:rooter_resolve_links = 1


" Load other vim
" execute 'source' fnameescape(s:config_home . '/keymap.vim')

for s:f in split(glob(s:config_home . '/pluginrc.d/*.vim'), '\n')
  execute 'source' fnameescape(s:f)
endfor