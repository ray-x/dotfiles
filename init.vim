set encoding=utf-8

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim


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

""""""""""""""Plugins"""""""""""""""""""""

execute 'source' fnameescape(s:config_home . '/pluginrc.d/dein')

" lua require('plugins')
" command! PackerInstall packadd packer.nvim | lua require('plugins').install()
" command! PackerUpdate packadd packer.nvim | lua require('plugins').update()
" command! PackerSync packadd packer.nvim | lua require('plugins').sync()
" command! PackerClean packadd packer.nvim | lua require('plugins').clean()
" command! PackerCompile packadd packer.nvim | lua require('plugins').compile()
""""""""""""""Plugins"""""""""""""""""""""

filetype plugin indent on

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
set completeopt=menuone,noinsert,noselect    " Show popup menu, even if there is one entry
set diffopt+=algorithm:patience
set diffopt+=iwhite

set pumheight=14                " Completion window max size
" set nocursorcolumn              " (turn off to speeds up highlighting)
" set nocursorline                " (turn off speeds up highlighting)
set lazyredraw                  " Wait to redraw
set autoread                    " Automatically read changed files
set termguicolors
" au FocusGained,BufEnter * :checktime  " autoload

" augroup vimrc
"   autocmd!
"    autocmd BufWinEnter,Syntax * syn sync minlines=200 maxlines=200
" augroup END

" syntax sync minlines=256
syntax on
" set synmaxcol=128
" set re=1

if !has('nvim')
  set ttyscroll=3                 " Speedup scrolling
  set ttymouse=xterm2
endif

" file hidden
set wildmenu
" set wildmode=longest:full,full
set wildmode=longest,list,full
set wildignore+=**/node_modules/**,/node_modules/*,*/tmp/*,*.so,*.swp,*.zip
if has('nvim')
  set wildoptions+=pum
  set pumblend=17
  set wildmode-=list
  set wildmode+=longest
  set wildmode+=full
endif

set cindent
set wrap

" Make it so that long lines wrap smartly
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible

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

" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */


set updatetime=400 "Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime


" yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=1500, on_visual=false}
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
    map <F14> <S-F2>
    map <F15> <S-F3>
    map <F16> <S-F4>
    map <F17> <S-F5>
    map <F18> <S-F6>
    map <F19> <S-F7>
    map <F20> <S-F8>
    map <F21> <S-F9>
    map <F22> <S-F10>
    map <F23> <S-F11>
    map <F24> <S-F12>
  endif
endif

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
"map <C-n> :cnext<CR>
"map <C-m> :cprevious<CR>
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
nnoremap <leader><leader>d "_d    "" \\dw to delete without put it to register

" Act like D and C
nnoremap Y y$
"
" set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.ist,*/.fdb_latex" mk,**/tmp/**,*/.so,*/.swp,*/.zip,*/.o

set grepprg=rg\ --vimgrep    " set grepprg=ag\ --vimgrep\ $*
" Ggrep only search files under git control
" set grepprg=git\ --no-pager\ grep\ --no-color\ -n\ $*
set grepformat=%f:%l:%m,%m\ %f\ match%ts,%f
" :grep 'pattern' after setup and :cfdo %s/Neovim/Nvim/g | update

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


" Tab/buffer
" map <C-H> :bn<CR>
" map <C-L> :bp<CR>
map <C-T>c BD <cr>
map <C-T>n :tabnew split<CR>

"" Python
au BufNewFile,BufRead *.py set colorcolumn=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set tabstop=4
" au BufNewFile,BufRead *.py setlocal foldmethod=indent
au BufNewFile,BufRead *.py vmap <CR> :s/\(^\s*\)/\1# /<CR>:let @/ = ""<CR>
au BufNewFile,BufRead *.py vmap <S-CR> :s/\(^\s*\)# /\1/<CR>:let @/ = ""<CR>


" markdown disable conceal when edit current line
set concealcursor="i"




" zc close, zo open  za toggle, zi open all, zm one level
if !&diff
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevel=4
  set foldnestmax=3
endif

if &diff
  set foldmethod=diff
  set diffopt+=context:0
  set cursorline
  set foldlevel=0
  set noreadonly
  colorscheme paleaurora
  set wrap
  finish  " skip all following 
endif


set number relativenumber " turn hybrid line numbers off set nonu nornu

set statusline+=%#warningmsg#

" set statusline+=%*
" open quickfix window automatically at x lines height
" let g:asyncrun_open = 8

augroup postUILoads
  autocmd!
   autocmd VimEnter * set clipboard^=unnamed
   autocmd VimEnter * set clipboard^=unnamedplus
augroup END

" file hidden
set wildmenu
set wildignore+=**/node_modules/**,/node_modules/*,*/tmp/*,*.so,*.swp,*.zip
if has('nvim')
  set wildoptions=pum
endif

if has('nvim')
  " Use cool floating wildmenu options
  set pumblend=17

  set wildmode-=list
  set wildmode+=longest
  set wildmode+=full

  " Makes floating PopUpMenu for completing stuff on the command line.
  "     Very similar to completing in insert mode.
  set wildoptions+=pum
else
  set wildmode=longest,list,full

  " Vim Galore recommended mappings
  " Make next and previous use smart history
  cnoremap <C-N> <Up>
  cnoremap <C-P> <Down>
end

set cindent
set wrap

" Make it so that long lines wrap smartly
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak


"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""


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



" command! Gt :lua require('selfunc').float_terminal()
command! Dg :lua require'lsp.diagnostic'.show_buf_diagnostics()
command! Dc :call dein#recache_runtimepath()
command! Du :call dein#update()