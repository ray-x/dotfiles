# vim_ide
* nvim+kitty configured with pop menu:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/menu.jpg)

* nvim clap preview:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/clap.jpg)

* nvim+kitty coc+ale:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/coc_float_errorcheck.jpg)


## Vim Plugins
I used to use slickedit, qt-creator, idea (webstorm, goland), vscode, but I am back to vi now. Thanks for `Plug` I do
not need to configure my setup everytime....... I am still using sublime edit(as a notepad)

vimr is one of the best nvim-gui. But it does not in active development in last 3 months(It is hard for a one developer project), some of the crash durning coding is annoying. I only use nvim/vim + kitty now.

I used following plugin a lots

* ``Plug``

   Plugin management tool

* vim-clap

   Best plugin for search anything. I used it to replace fzf, leaderF, leaderP, NerdTree, Ag/Ack/Rg, yank(ring), project management. undolist and many more

* coc.nvim

   I disabled vim-go and turn to coc-go. Replace defx with coc-explorer, use coc-spell for spell check
   coc-snippet replaced my ultisnips. Also, there are coc for yml, json, prettier, python, rust, PHP (any language vs code
   supported)......
   With Clap+coc and colorscheme(onedark/spacevim) setup. It is a full featured IDE. 

* ALE

  well, I am still using ALE and configure lots of lint tool with it. It is good to find something compiler missing.

* Programming support:

  YCM (used to be my favourite, only for C++ and python now), but I am using coc.nvim more offen now, vim-go(for go testing, highlight, gopls disabled),CompleteParameter, emmet-vim, tagbar/vista, polygot, and some language specific plugins (e.g html, js/ts, swift), ctags/gutentags, vim-less, govim(macvim only, with some cool AST)

* Debug:

  vimspector

* Theme, look&feel:

  onedark, eleline, devicons, startify, powerline, indentLine(with nerdfont),

* Color:

  nvim-colorizer.lua (display hex and color in highlight), rainbow, log-highlight, limelight, interestingwords

* Git:

  fugitive, gv, coc-git

* Format:

  tabular, coc-prettier(or, sometimes prettier), auto-pair

* Menu and tab:
  quickui(created a menu for the function/keybind I used less often. I can not rememeber all the commands and keybinds....)
  wintab: one of the best buffer management tool

* Tools: floatterm, coc-todolist

* Move and Edit:

  easymotion, multi-cursor (has ome bugs with auto-complete. check this: [You don’t need more than one cursor in vim](https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db)
), vim-anyfold (better folding)

## Shell

* OMZshell is good, iterm2 is popular, but I turned to zprezto(with powerlevel10) + kitty. It is cooool and faster.
