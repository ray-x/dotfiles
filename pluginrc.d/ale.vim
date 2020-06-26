" ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_go_gopls_executable = 'gopls'
let g:ale_go_revive_executable = 'revive'
let g:ale_go_golangci_lint_options = '--enable-all --disable dogsled --disable gochecknoglobals --disable gochecknoinits --disable gocognit --disable godot --disable godox --disable goprintffuncname --disable lll --disable nestif --disable wsl --disable golint --disable gocyclo --disable asciicheck'
let g:ale_go_golangci_lint_package=0
" golangci-lint will run on vim-go
let g:ale_lint_delay = 100
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_column_always = 0

let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'javascript.jsx': ['eslint', 'flow-language-server'],
\   'go': ['go vet', 'staticcheck', 'gobuild', 'golangci_lint', 'revive'],
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
\}


autocmd! BufWritePost * Neomake
let g:neomake_go_enabled_makers = [ 'golangci_lint', 'golint' ]
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'dupl',
  \   '-D', 'gocyclo',
  \   '-D', 'gotype',
  \   '-E', 'errcheck',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }