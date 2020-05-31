" This file is only loaded in GUIs

" let g:Guifont=Hack\ Regular:h14
" let g:guifont=DejaVu Sans Mono:h14

" Neovim-qt Guifont command
" Set the font to DejaVu Sans Mono:h13
" :Guifont Hack:h15
autocmd VimEnter * highlight Comment cterm=italic gui=italic
" Guifont SourceCodePro\ Nerd\ Font:h14
" vimr doesn't support :Guifont
if !has("gui_vimr") && has('nvim')
	:Guifont FiraCode Nerd Font:h12
	:GuiTabline 0
endif

" macvim
"if !has('nvim')
if has('gui_macvim')
	set guifont=FiraCode\ Nerd\ Font:h12
endif


" mouse copy paste
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
" Paste with middle mouse click
vmap <LeftRelease> "*ygv


" Paste with <Shift> + <Insert>
cmap <S-Insert> <C-R>*
cmap <C-V> <C-R>*
imap <C-V> <C-R>*
