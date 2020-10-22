"" Lua plugins
if has('nvim')

autocmd BufNewFile,BufRead *.go,*.sh,*.cs,*.cpp,*.c,*.css,*.dart,*.html,*.java,*.js,*.jsdoc,*.json,*.lua,*.py,*.rs,*.ruby,*.toml,*.ts,*tsx silent!  lua require('treesitter')


augroup ScrollbarInit
  autocmd!
  autocmd WinEnter,FocusGained,CursorMoved,VimResized * silent! lua require('scrollbar').show()
  autocmd WinLeave,FocusLost                          * silent! lua require('scrollbar').clear()
augroup end

augroup config_scrollbar_nvim
    autocmd!
    autocmd BufEnter    * silent! lua require('scrollbar').show()
    autocmd BufLeave    * silent! lua require('scrollbar').clear()
    autocmd FocusGained * silent! lua require('scrollbar').show()
    autocmd FocusLost   * silent! lua require('scrollbar').clear()
    autocmd CursorMoved * silent! lua require('scrollbar').show()
    autocmd VimResized  * silent! lua require('scrollbar').show()
augroup end

" autocmd BufEnter * lua require'completion'.on_attach()
endif  ""nvim