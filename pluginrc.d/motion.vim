"easy motion default:" <leader><leader>  \w(forward) \b(ack) \j(up) \k(down)  \s(search)


map <Leader> <Plug>(easymotion-prefix)
nmap s         <Plug>(easymotion-s2)
xmap s         <Plug>(easymotion-s2)
omap z         <Plug>(easymotion-s2)
nmap <Leader>s <Plug>(easymotion-sn)
xmap <Leader>s <Plug>(easymotion-sn)
omap <Leader>z <Plug>(easymotion-sn)
vmap <Leader>j <Plug>(easymotion-j)


map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
map  <Leader>n <Plug>(easymotion-next)
map  <Leader>N <Plug>(easymotion-prev)

map <Leader>l <Plug>(easymotion-lineforward)
vmap <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
vmap <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Require tpope/vim-repeat to enable dot repeat support
" Jump to anywhere with only `s{char}{target}`
" `s<CR>` repeat last find motion.
nmap <Leader><ctrl+s> <Plug>(easymotion-s)

" Bidirectional & within line 't' motion
" omap t <Plug>(easymotion-bd-tl)

" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1

" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1

" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())



let g:camelcasemotion_key = '<leader><leader>' " use default  \\w \\e \\b \\ge ...

map <Leader><s-w> <Plug>CamelCaseMotion_w
map <Leader><s-b> <Plug>CamelCaseMotion_b
map <Leader><s-e> <Plug>CamelCaseMotion_e
map <Leader><s-g>e <Plug>CamelCaseMotion_ge

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie