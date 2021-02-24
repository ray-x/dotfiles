if &diff
	finish
endif
 "" markdown
 let g:vim_markdown_frontmatter = 1
 let g:vim_markdown_strikethrough = 1
 let g:vim_markdown_folding_level = 6
 let g:vim_markdown_override_foldtext = 1
 let g:vim_markdown_folding_style_pythonic = 1
 let g:vim_markdown_conceal = 1
 let g:vim_markdown_conceal_code_blocks = 1
 let g:vim_markdown_new_list_item_indent = 0
 let g:vim_markdown_toc_autofit = 0
 let g:vim_markdown_edit_url_in = 'vsplit'
 let g:vim_markdown_fenced_languages = ['c++=javascript',  'js=javascript', 'json=javascript', 'jsx=javascript',  'tsx=javascript'] "} )

command! Spell call spelunker#check()

let g:enable_spelunker_vim_on_readonly = 0
let g:spelunker_check_type = 0
let g:spelunker_highlight_type = 2
let g:spelunker_disable_uri_checking = 1
let g:spelunker_disable_account_name_checking = 1
let g:spelunker_disable_email_checking = 1


augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 2:
  " autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md,*.go call spelunker#check_displayed_words()
augroup END"

" autocmd FileType markdown setlocal spell

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" interestingwords
let g:interestingWordsDefaultMappings=0
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']

let g:interestingWordsDefaultMappingsK=0
nnoremap <silent> <leader>u :call InterestingWords('n')<cr>
vnoremap <silent> <leader>u :call InterestingWords('v')<cr>
nnoremap <silent> <leader>U :call UncolorAllWords()<cr>
" nnoremap <silent> <leader>U :call UncolorAllWords()<cr>
let g:interestingWordsDefaultMappingsN=0
nnoremap <silent> m :call WordNavigation('forward')<cr>
nnoremap <silent> M :call WordNavigation('backward')<cr>
let g:interestingWordsRandomiseColors = 1



let g:markdown_composer_autostart = 0

" disable highligh for large file  1M in this case
autocmd BufReadPre * if getfsize(expand("%")) > 1000000 | syntax off | endif


" let g:sql_type_default = 'pgsql'
let g:omni_sql_no_default_maps = 1



nmap <leader>ft :FloatermNew <CR>
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'neovim',
  \ 'suite':   'neovim',
\}
" let test#neovim#term_position = "topleft"
" let test#neovim#term_position = "vert"
let test#neovim#term_position = "vert botright 60"
let test#go#runner = 'ginkgo'

"vim test
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" let g:delimitMate_expand_cr = 1
" let g:delimitMate_expand_space = 1
" let g:delimitMate_expand_inside_quotes = 1


let g:git_messenger_include_diff = 'none'
let g:git_messenger_always_into_popup = 1


let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/github/dotfiles' },
            \ ]
let g:startify_change_to_vcs_root = 1

let g:startify_enable_special = 0
let g:startify_change_to_dir = 1

" autocmd FileType LuaTree setlocal nowrap


" emmet"
let g:user_emmet_install_global = 1
" autocmd FileType html,css EmmetInstall
"enable all function in all mode.
let g:user_emmet_mode='a'




" Far
let g:far#source = 'rgnvim'
let g:far#enable_undo = 1
" let g:far#ignore_files = ['.git/']

" copy/paste"
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)



let g:Illuminate_delay = 200
let g:Illuminate_ftblacklist = ['nerdtree', 'nvimtree', 'vista']

" let g:Illuminate_ftwhitelist = ['vim', 'sh', 'python', 'go', 'cpp']"