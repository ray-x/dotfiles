" vim-go
" I only use vim-go for 
" 1) lint on save  :GoMetaLinter :GoLint :GoVet :GoErrCheck (some was done with ALE)
" 2) Test, build, run (may use coc-action to replace), coverage
" 3) auto import
" 4) rename...
" 5) Guru? :GoReferrers(only with pls, use coc reference instead) :GoCallees/ers :GoImplements (slow...)
" 6) sameids hightlight


" Not been used:
" debug: use viminspector
" autocomplete: use coc (can use vim-go at same time, but will spawn two gopls server...)
" struct tag GoAddTags/GoRemoveTags use go.tags.add in coc-go

let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0
" let g:go_metalinter_command = "golangci-lint"  " use ALE golangci-lint
" let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"
" let g:go_metalinter_autosave_enabled = ["govet", "errcheck", "bodyclose", "goerr113", "stylecheck", "unconvert", "prealloc", "gosec", "prealloc", "nolintlint", "goimports", "dupl"]
" let g:go_metalinter_enabled = ["govet", "errcheck", "bodyclose", "goerr113", "stylecheck", "unconvert", "prealloc", "gosec", "prealloc", "nolintlint", "goimports", "dupl"]

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_code_completion_enabled = 0 "use coc-go
let g:go_gopls_enabled = 0 "use coc-go
let g:go_info_mode = ""
let g:go_auto_type_info = 0
let g:go_doc_keywordprg_enabled = 0  "godoc use <slient> K conflict with coc, also it is slow....
let g:go_textobj_enable = 0  "use coc for textobj
let g:go_echo_go_info = 0 "guru is too slow, pls too much memory if multiple proj opens
let g:go_def_mapping_enabled = 0 "disable default key mapping because we disabled gopls gd/gr/gf wont work


" Open :GoDeclsDir with ctrl-g
" nmap <C-g> :GoDeclsDir<cr>   "need ctrlp/fzf  but none installed
" imap <C-g> <esc>:<C-u>GoDeclsDir<cr>
nnoremap <leader>gi :GoImport <C-R><C-W><cr>
inoremap <leader>gi <Esc>:GoImport <C-R><C-W><cr>A.


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>gt  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  " autocmd FileType go nmap <Leader>gd <Plug>(go-doc)  " not work if gopls disable

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  " autocmd FileType go nmap <Leader>i <Plug>(go-info)  " not work if pls and info disabled

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split not work if pls and info disabled
  " autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split not work if pls and info disabled
  " autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  " au FileType go nmap <Leader>gr <Plug>(go-referrers)   " not work if pls and info disabled
  " au FileType go nmap <Leader>dt <Plug>(go-def-tab)  "" not work if pls and info disabled

  " au FileType go nmap <Leader>gv <Plug>(go-doc-vertical) " not work if gopls disable

  au FileType go nmap <Leader>ge <Plug>(go-rename)  

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" autocmd FileType go nmap <Leader>s <Plug>(go-implements)
" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nmap <Leader>gd <Plug>(go-doc)
" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" au FileType go nmap <leader>r <Plug>(go-run)
" au FileType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)
" au FileType go nmap <Leader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>gr <Plug>(go-referrers)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" au FileType go nmap <Leader>e <Plug>(go-rename)


" note: auto_sameid will highlight identifiers under cursor. no longer work, use coc
" let g:go_auto_sameids = 0
