let g:spelunker_disable_uri_checking = 1
" Disable account name checking, e.g. @foobar, foobar@. (default: 0)
" NOTE: Spell checking is also disabled for JAVA annotations.
let g:spelunker_disable_account_name_checking = 1

" Disable acronym checking. (default: 0)
let g:spelunker_disable_acronym_checking = 1

" Disable checking words in backtick/backquote. (default: 0)
let g:spelunker_disable_backquoted_checking = 1

" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  " autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md,*.go,*.py,*.ts,*.tsx,*.cpp,*.c,*.html call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  " autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md,*.go,*.py,*.ts,*.tsx,*.cpp,*.c,*.html call spelunker#check_displayed_words()
augroup END