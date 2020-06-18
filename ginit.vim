" This file is only loaded in GUIs

" let g:Guifont=Hack\ Regular:h14
" let g:guifont=DejaVu Sans Mono:h14

" Neovim-qt Guifont command
" Set the font to DejaVu Sans Mono:h13
" :Guifont Hack:h15
autocmd VimEnter * highlight Comment cterm=italic gui=italic
" Guifont SourceCodePro\ Nerd\ Font:h14
" vimr doesn't support :Guifont
if !has("gui_vimr") && has('nvim') && !exists('g:fvim_loaded')
	:Guifont FiraCode Nerd Font:h12
	:GuiTabline 0
endif

" macvim
"if !has('nvim')
if has('gui_macvim')
	set guifont=JetBrainsMono\ Nerd\ Font:h18
	set macligatures
    let g:macvim_skip_colorscheme=1
endif

if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility
    set guifont=FiraCode\ Nerd\ Font:h12
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
endif


" mouse copy paste
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
