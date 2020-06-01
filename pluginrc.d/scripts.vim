" Strip trailing whitespace and newlines on save
fun! <SID>StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    %s/\($\n\s*\)\+\%$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespace()

"
"
"
" source /Users/rayx/.vim/vim/asc.vim
" source /Users/rayx/.vim/vim/skywind.vim
"
" Search in project
"
function! FindProjectRoot(lookFor)
    let s:root=expand('%:p:h')
    let pathMaker='%:p'
    while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
        let pathMaker=pathMaker.':h'
        let fileToCheck=expand(pathMaker).'/'.a:lookFor
        if filereadable(fileToCheck)||isdirectory(fileToCheck)
            let s:root=expand(pathMaker)
        endif
    endwhile
    return s:root
endfunction
let g:root_dir = FindProjectRoot('.git')   " 搜索 .git 为项目路径

autocmd BufEnter * silent! lcd g:root_dir  " 设置当前路径为项目路径