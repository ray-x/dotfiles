autocmd BufRead,BufNewFile *.htm,*.html,*.js,*.ts,*.yml,*.yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

au FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"
au FileType markdown let b:prettier_exec_cmd = "prettier" | let g:prettier#exec_cmd_path = "/usr/local/bin/prettier" | let g:spelunker_check_type = 1


autocmd BufRead,BufNewFile *.htm,*.html,*.js,*.ts,*.go,*.c,*.h,*.cpp,*.tsx set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevel=4 foldnestmax=3


"+++ Go +++
:command GoModTidy !go mod tidy -v

augroup auto_go
  " autocmd BufWritePre *.go :lua vim.lsp.buf.code_action({ source = { organizeImports = true } })
  au BufWritePost *.sum :silent :GoModTidy
  au BufWritePost *.mod :silent :GoModTidy
  " au BufWritePre *.go lua require('internal.golines').golines_format()
  " autocmd BufWriteCmd *.mod :GoModFmt "enabled by default
  " autocmd BufWritePost *.mod :%! go mod tidy
  " autocmd BufWritePost *_test.go :AsyncRun -raw -cwd=%:p:h go test ./... -tags=integration | lopen 3
augroup end
