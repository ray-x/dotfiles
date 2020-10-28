" gutentags
" brew install global; pip install pygments
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