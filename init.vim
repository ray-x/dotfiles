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

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'liuchengxu/vista.vim', { 'on': ['Vista!!','Vista'] }
Plug 'kamykn/spelunker.vim'
" Plug 'kamykn/popup-menu.nvim'  "spell popup

Plug 'voldikss/vim-floaterm', { 'on': ['FloatermNew'] }
Plug 'skywind3000/asynctasks.vim', { 'on': ['AsyncRun', 'AsyncRun!', 'AsyncTask'] }
Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun', 'AsyncRun!', 'AsyncTask'] }

" language support
Plug 'lifepillar/pgsql.vim' , { 'for': ['sql','plsql', 'pgsql'] }

" HTML
Plug 'mattn/emmet-vim' , { 'for': ['html','css', 'js', 'ts', 'tsx'] }
Plug 'Raimondi/delimitMate', { 'for': ['html','css'] }

Plug 'preservim/nerdcommenter' " add comments to code, tomtom/tcomment_vim is another alternative

Plug 'mhinz/vim-startify'

" theme
Plug 'ray-x/paleaurora'
" Plug 'kyazdani42/nvim-palenight.lua'
" Plug 'NLKNguyen/papercolor-theme'     "" one will need at least a light color, ayu-vim light is another option
" Plug 'morhetz/gruvbox'


" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp', { 'for': ['markdown'] } "math support
" Plug 'iamcco/markdown-preview.vim', { 'for': ['markdown'] }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }

"  Aligning Text with Tabular.vim  :Tabularize  or \=
Plug 'godlygeek/tabular'

Plug 'fatih/vim-go', { 'for': ['go', 'gomod', 'mod', 'tmpl'] , 'do': ':GoInstallBinaries' }
Plug 'buoto/gotests-vim', { 'for': ['go'] }


" put lua plugins in one place, might be good for performance"
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/diagnostic-nvim'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'RishabhRD/popfix'
  Plug 'RishabhRD/nvim-lsputils'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/completion-treesitter'
  Plug 'steelsojka/completion-buffers'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua' " , { 'on': 'LuaTreeToggle' }
  Plug 'Akin909/nvim-bufferline.lua'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'Xuyuanp/scrollbar.nvim'
  Plug 'tjdevries/express_line.nvim'
  Plug 'tveskag/nvim-blame-line' " , { 'on': ['EnableBlameLine', 'ToggleBlameLine', 'SingleBlameLine']}
endif

" Show color
Plug 'norcalli/nvim-colorizer.lua'

" for pager
Plug 'norcalli/nvim-terminal.lua'


Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify', { 'on': ['SignifyEnable', 'SignifyEnableAll', 'SignifyToggle'] }

Plug 'junegunn/gv.vim', { 'on': 'GV' }  "git commit browser. :GV(!|?) move: ]]/ [[

" async linter
Plug 'w0rp/ale' , { 'on': ['ALEEnable', 'ALEEnableBuffer'] }

Plug 'vim-test/vim-test' , { 'on': ['TestNearest', 'TestFile', 'TestSuite'] }

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat' " repead motion"
Plug 'bkad/CamelCaseMotion'

" Plug 'pseewald/vim-anyfold', { 'on': ['AnyFoldActivate']}

Plug 'liuchengxu/vim-clap'  , { 'do': { -> clap#installer#force_download() } } " keep the binary for a while. download and rebuild took time

Plug 'simnalamburt/vim-mundo'  " visualizes the Vim undo tree

"Rainbow Parentheses Improved"
Plug 'luochen1990/rainbow'

" display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
Plug 'mtdl9/vim-log-highlighting' , { 'for': ['json', 'txt', 'log'] }

" highlight current word
Plug 'ray-x/vim-interestingwords'

" Add plugins to &runtimepath
call plug#end()


autocmd StdinReadPre * let s:std_in=1


""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
set nocompatible                " Enables us Vim specific features
" filetype off                    " Reset filetype detection first ...
" filetype plugin indent on       " ... and enable filetype detection
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
set fileformats=unix,mac,dos    " Prefer Unix over Windows over OS 9 formats
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=14                " Completion window max size
" set nocursorcolumn              " (turn off to speeds up highlighting)
" set nocursorline                " (turn off speeds up highlighting)
set lazyredraw                  " Wait to redraw
set autoread                    " Automatically read changed files

" au FocusGained,BufEnter * :checktime  " autoload

" augroup vimrc
"   autocmd!
"    autocmd BufWinEnter,Syntax * syn sync minlines=200 maxlines=200
" augroup END

" syntax sync minlines=256

" set synmaxcol=128
" set re=1

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

set fdm=syntax
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */


set updatetime=300 "Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime


" yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
augroup END

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo/
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

set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.ist,*/.fdb_latexmk,**/tmp/**,*/.so,*/.swp,*/.zip,*/.o

set grepprg=rg\ --vimgrep    " set grepprg=ag\ --vimgrep\ $*
" Ggrep only search files under git control
" set grepprg=git\ --no-pager\ grep\ --no-color\ -n\ $*
set grepformat=%f:%l:%m,%m\ %f\ match%ts,%f
" :grep 'pattern' after setup and :cfdo %s/Neovim/Nvim/g | update

"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

set mouse=a


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
map <C-H> :bn<CR>
map <C-L> :bp<CR>
map <C-T>c Bw <cr>
map <C-T>n :tabnew split<CR>

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

" markdown disable conceal when edit current line
set concealcursor="i"

nmap <leader>ft :FloatermNew <CR>

""""""""Folding
" autocmd Filetype * AnyFoldActivate               " activate for all filetypes
" autocmd Filetype cpp set foldignore=#/

" let g:anyfold_identify_comments=2
" let g:anyfold_fold_comments=1

" disable anyfold for large files
" let g:LargeFile = 1000000 " file is large if size greater than 1MB
" autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
" function LargeFile()
"     augroup anyfold
"         autocmd! " remove AnyFoldActivate
"         autocmd Filetype <filetype> setlocal foldmethod=indent " fall back to indent folding
"     augroup END
" endfunction


set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'neoterm',
  \ 'suite':   'neoterm',
\}

"vim test
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let g:floaterm_keymap_toggle = '<F12>'

" open quickfix window automatically at x lines height 
let g:asyncrun_open = 8


let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('/tmp/lsp.log')

autocmd VimEnter * nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>
autocmd VimEnter * nnoremap <buffer> <silent> g<LeftMouse> <LeftMouse><cmd>lua vim.lsp.buf.implementation()<CR>

augroup ScrollbarInit
  autocmd!
  autocmd WinEnter,FocusGained,CursorMoved,VimResized * silent! lua require('scrollbar').show()
  autocmd WinLeave,FocusLost                          * silent! lua require('scrollbar').clear()
augroup end

augroup config_scrollbar_nvim
    autocmd!
    autocmd BufEnter    * silent! lua require('scrollbar').show()
    autocmd BufLeave    * silent! lua require('scrollbar').clear()
    autocmd FocusGained * silent! lua require('scrollbar').show()
    autocmd FocusLost   * silent! lua require('scrollbar').clear()
    autocmd CursorMoved * silent! lua require('scrollbar').show()
    autocmd VimResized  * silent! lua require('scrollbar').show()
augroup end


""""""""" Load lua plugins """""""""
" lua require('init')
augroup postUILoads
  autocmd!
   autocmd VimEnter * lua require('lsp_init')
   autocmd VimEnter * lua require('lsp_location')
   autocmd VimEnter * lua require('treesitter')
   autocmd VimEnter * set clipboard^=unnamed
   autocmd VimEnter * set clipboard^=unnamedplus
   autocmd VimEnter * silent! lua require('expressline')
augroup END


" "treesitter breaks from time to time :(
" lua require('treesitter')
lua require'bufferline'.setup{
\  options = {
\    view = "multiwindow",
\    numbers = "ordinal",
\    mappings = true,
\    max_name_length = 16,
\    tab_size = 16,
\    separator_style = "thin",
\    always_show_tab = false,
\  },
\ }

" let g:vimspector_enable_mappings = 'HUMAN'
" autocmd FileType txt let g:deoplete#enable_at_startup = 1

""""""""" Load other vim plugin config """""""""
" execute 'source' fnameescape(s:config_home . '/keymap.vim')

for s:f in split(glob(s:config_home . '/pluginrc.d/*.vim'), '\n')
   execute 'source' fnameescape(s:f)
endfor
" 
if has('nvim')
  for s:f in split(glob(s:config_home . '/pluginrc.d/*.nvim'), '\n')
    execute 'source' fnameescape(s:f)
  endfor
endif

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" let g:user_emmet_leader_key='<C-Z>'  " <C-Y> leader"


command! Spell :call spelunker#check()

let g:enable_spelunker_vim_on_readonly = 0
let g:spelunker_check_type = 0
let g:spelunker_highlight_type = 2
let g:spelunker_disable_uri_checking = 1
let g:spelunker_disable_account_name_checking = 1
let g:spelunker_disable_email_checking = 1


augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 2:
  autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md,*.go call spelunker#check_displayed_words()
augroup END" 

" autocmd FileType markdown setlocal spell

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nmap <S-F1> :LuaTreeToggle<CR>

let g:interestingWordsDefaultMappings=0
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']

let g:interestingWordsDefaultMappingsK=0
nnoremap <silent> <leader>u :call InterestingWords('n')<cr>
" nnoremap <silent> <leader>U :call UncolorAllWords()<cr>
let g:interestingWordsDefaultMappingsN=0
nnoremap <silent> m :call WordNavigation('forward')<cr>
nnoremap <silent> M :call WordNavigation('backward')<cr>

let g:interestingWordsRandomiseColors = 1

autocmd Filetype LuaTree set cursorline