" Set floaterm window's background to black
hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guibg=orange guifg=cyan
command! FZF FloatermNew fzf
let g:floaterm_gitcommit='split'

let g:floaterm_keymap_new    = '<S-F7>'
let g:floaterm_keymap_prev   = '<S-F8>'
let g:floaterm_keymap_next   = '<S-F9>'
let g:floaterm_keymap_toggle = '<S-F12>'
command! NNN FloatermNew nnn
command! LG FloatermNew --height=0.96 --width=0.96  --wintype=floating --name=lazygit --autoclose=2 lazygit
command! Ranger FloatermNew --height=0.96 --width=0.96  --wintype=floating --name=lazygit --autoclose=2  ranger

