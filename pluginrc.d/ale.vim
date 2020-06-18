" ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_go_gopls_executable = 'gopls'
let g:ale_go_revive_executable = 'revive'
let g:ale_go_golangci_lint_options = '--enable-all --disable dogsled --disable gochecknoglobals --disable gochecknoinits --disable gocognit --disable godot --disable godox --disable goprintffuncname --disable lll --disable nestif --disable wsl --disable golint --disable gocyclo --disable asciicheck'
let g:ale_go_golangci_lint_package=1
" golangci-lint will run on vim-go
let g:ale_lint_delay = 100
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_column_always = 0

let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'javascript.jsx': ['eslint', 'flow-language-server'],
\   'go': ['go vet', 'staticcheck', 'gobuild', 'golangci_lint', 'revive'],
\}

let g:ale_fixers = {
\   'go': ['goimports'],
\   'javascript': ['prettier', 'eslint'],
\   'javascript.jsx': ['prettier', 'eslint'],
\   'typescript': ['eslint', 'tslint'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'php': ['php-cs-fixer'],
\}
