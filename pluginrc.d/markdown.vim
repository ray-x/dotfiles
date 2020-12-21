let g:markdown_fenced_languages = ['bash=sh', 'c', 'cpp', 'java', 'ruby', 'python', 'latex=tex','js=javascript', 'json=javascript', 'html', 'css']

let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0
autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync