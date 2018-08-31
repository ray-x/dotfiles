
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
Plug 'ervandew/supertab'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'rhysd/vim-clang-format'
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'honza/vim-snippets'

" Plugin options
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'keith/swift.vim'

Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'mhinz/vim-grepper'
" Plug 'nvie/vim-flake8'
Plug 'vim-syntastic/syntastic'
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Yggdroot/LeaderF'

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'neovim/python-client'
Plug 'zchee/deoplete-jedi' 


Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py  --clang-completer --go-completer --clang-tidy' }
Plug 'Shougo/echodoc.vim'
Plug 'tenfyzhong/CompleteParameter.vim'


Plug 'tomasr/molokai'
Plug 'Lokaltog/vim-powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
" Plug 'wincent/command-t'


" Plug 'w0rp/ale' 


Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' },
Plug 'skywind3000/gutentags_plus',

Plug 'zefei/vim-wintabs',
Plug 'zefei/vim-wintabs-powerline',
"Plug 'ap/vim-buftabline'
Plug 'pboettch/vim-highlight-cursor-words'
Plug 'skywind3000/vim-preview'


"Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Plug 'honza/vim-snippets'

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'


" Add plugins to &runtimepath
call plug#end()

" ycm
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'

let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'





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
"set background = dark
"colorscheme fx
" set guifont=Monaco:h14




set background=dark
colorscheme molokai
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
set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai



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

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = 'find %s -type f'



"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

" brew install gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }


" let g:flake8_cmd="/usr/local/bin/flake8"
" let g:flake8_quickfix_location="topleft"
" let g:flake8_quickfix_height=7
" 
" let g:flake8_error_marker='EE'     " set error marker to 'EE'
" let g:flake8_warning_marker='WW'   " set warning marker to 'WW'
" let g:flake8_pyflake_marker=''     " disable PyFlakes warnings
" let g:flake8_complexity_marker=''  " disable McCabe complexity warnings
" let g:flake8_naming_marker=''      " disable naming warnings
" 
" highlight link Flake8_Error      Error
" highlight link Flake8_Warning    WarningMsg
" highlight link Flake8_Complexity WarningMsg
" highlight link Flake8_Naming     WarningMsg
" highlight link Flake8_PyFlake    WarningMsg

" autocmd BufWritePost *.py call Flake8()
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_aggregate_errors = 1
" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225'
let g:syntastic_auto_loc_list = 1
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_highlighting=1
let g:syntastic_enable_signs=1
highlight SyntasticErrorLine guibg=#550000
highlight SyntasticWarningLine guibg=#331d1e

function! BuildYCM(info)
   if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --go-completer --python-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp'], 'do': function('BuildYCM') }
Plug 'tenfyzhong/CompleteParameter.vim'

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

let g:deoplete#enable_at_startup = 1

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<c-=>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
set mouse=a
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" brew install gloabl; pip install pygments
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project', '.gutctags']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_modules = []
let g:gutentags_enabled = 0
" enable both universal ctags and gtags
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
" put tags in cache
let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:gutentags_ctags_extra_args = ['--fields=+niazS']
autocmd FileType cpp let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
autocmd FileType c let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" uctags
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" uctags reference
let g:gutentags_ctags_extra_args += ['--fields=+r']

" disable gtags load
let g:gutentags_auto_add_gtags_cscope = 0

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
nmap gs <plug>(GrepperOperator)	" " 选择字符后按 g + s 开始搜索（异步的）
xmap gs <plug>(GrepperOperator)
let g:grepper = {}
let g:grepper.ag = {}
let g:grepper.ag.grepprg = 'ag --vimgrep $* '.g:root_dir " 设置 ag 参数
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


" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>gt  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  au FileType go nmap <Leader>gr <Plug>(go-referrers)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  au FileType go nmap <Leader>ge <Plug>(go-rename)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" autocmd FileType go nmap <Leader>s <Plug>(go-implements)
" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nmap <Leader>gd <Plug>(go-doc)
" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" au FileType go nmap <leader>r <Plug>(go-run)
" au FileType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)
" au FileType go nmap <Leader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>gr <Plug>(go-referrers)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

" paste and copy
"
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P


