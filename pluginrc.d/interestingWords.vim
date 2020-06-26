let g:interestingWordsDefaultMappings=0
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
"  interesting words conflict with easymotion"

let g:interestingWordsDefaultMappingsK=0
nnoremap <silent> <leader>u :call InterestingWords('n')<cr>
" nnoremap <silent> <leader>U :call UncolorAllWords()<cr>
let g:interestingWordsDefaultMappingsN=0
nnoremap <silent> m :call WordNavigation('forward')<cr>
nnoremap <silent> M :call WordNavigation('backward')<cr>

let g:interestingWordsRandomiseColors = 1