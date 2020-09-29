" ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_go_gopls_executable = 'gopls'
let g:ale_go_revive_executable = 'revive'

let g:ale_go_golangci_lint_options = '--enable-all --disable dogsled --disable gocognit --disable godot --disable godox --disable lll --disable nestif --disable wsl --disable gocyclo --disable asciicheck --disable gochecknoglobals'
let g:ale_lint_delay = 1000                 " begin lint after 1s
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'normal'   " do not lint when I am typing
let g:ale_sign_column_always = 0
let g:ale_go_golangci_lint_package = 1

" 'go vet' not working
let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'javascript.jsx': ['eslint', 'flow-language-server'],
\   'go': ['golangci-lint', 'revive'],
\   'markdown': ['mdl', 'languagetool'],
\   'sql': ['sqlint'],
\}

let g:ale_fixers = {
\   'go': ['goimports'],
\   'javascript': ['prettier', 'eslint'],
\   'javascript.jsx': ['prettier', 'eslint'],
\   'typescript': ['eslint', 'tslint'],
\   'json': ['prettier'],
\   'sql': ['pgformatter'],
\   'css': ['prettier'],
\   'php': ['php-cs-fixer'],
\   'ale_fixers':['prettier', 'remark'],
\}


" let g:neomake_go_enabled_makers = [ 'golangci_lint', 'go' ]
" let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
" let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
" let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
" let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}


augroup auto_go
  " autocmd BufWritePre *.go lua vim.lsp.buf.code_action({ source = { organizeImports = true } })
  autocmd BufWritePre *.go :GoFmt
  autocmd BufWriteCmd *.mod :GoModFmt
  autocmd BufWritePost *.mod :AsyncRun -cwd=<root> go mod tidy
  " autocmd BufWritePost *_test.go :AsyncRun -raw -cwd=%:p:h go test ./... -tags=integration | lopen 3
augroup end

