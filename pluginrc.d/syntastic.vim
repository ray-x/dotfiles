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

