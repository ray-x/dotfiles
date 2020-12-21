autocmd BufRead,BufNewFile *.htm,*.html,*.js,*.ts setlocal tabstop=2 shiftwidth=2 softtabstop=2

au FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"
au FileType markdown let b:prettier_exec_cmd = "prettier"
let g:prettier#exec_cmd_path = "/usr/local/bin/prettier"

autocmd BufRead,BufNewFile *.htm,*.html,*.js,*.ts,*.go,*.c,*.h,*.cpp,*.tsx set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevel=4 foldnestmax=3
