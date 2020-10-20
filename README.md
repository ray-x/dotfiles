# vim as a programming IDE

I used to use slickedit, qt-creator, idea (webstorm, goland), vscode, but I am back to vi now. Thanks for `Plug` I do
not need to configure my setup everytime....... I am still using sublime edit(as a notepad)

vimr is one of the best nvim-gui. But it does not in active development in last 3 months(It is hard for a one developer
project), some of the crash durning coding is annoying. I only use nvim/vim + kitty now.

Note: it is a zprezto(zsh)+Plug(vim) version. I had changed to more lightweight zim+dein(see master branch) to reduce startup time.

* nvim+kitty configured with pop menu:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/menu.jpg)

* nvim clap preview:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/clap.jpg)

* nvim+kitty coc+ale:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/coc_float_errorcheck.jpg)


## Neovim Plugins
There are lots of amazing plugins,
I used following plugin a lots

* ``Plug``

   Plugin management tool. The configuration was optimized and lots of plugins are loaded lazily. Normally the startup time
   is around 200ms.

* vim-clap

   Best plugin for search anything. I used it to replace fzf, leaderF, leaderP, NerdTree, Ag/Ack/Rg, yank(ring), project management. undolist and many more

* nvim-lsp/coc.nvim

   I disabled vim-go auto-complete/LSP and turn to nvim-lsp.
   Defx: file-explorer,
   nvim-lua/completion-nvim: auto-complete,
   vsnip: code snipts(Load snippet from VSCode extension). It is a full featured IDE.

   I put coc in graveyard. It works fine, but from time to time, there will be some dead node.js need to clean up manually.
   Also it growing bigger and slower.......

   If you enable coc, would be

   ```vim
 Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
 Plug 'vn-ki/coc-clap'
   ```
   The coc.vim in graveyard folder is a good reference how to configure it.
   Replace defx with coc-explorer, use coc-spell(remove spelunker) for spell check
   coc-snippet replaced my ultisnips. Also, there are coc for yml, json, prettier, python, rust, PHP (any language vs code
   supported)......
   With Clap+coc and colorscheme(ray-x/paleaurora) setup.

* ALE

  Well, I am still using ALE and configure lots of lint tool with it. It is good to find something compiler missing.

* Programming support:

  YCM (used to be my favourite, only for C++ and python now), but I am using lsp more offen now, primary using nvim-lsp for autocomplete and syntax check.
  vim-go(for go testing, highlight, gopls disabled), vsnipt, emmet-vim, tagbar/vista, and some language specific plugins (e.g html, js/ts, swift),  tree-sitter with some cool AST highlight.

* Debug:

  vimspector

* Theme, look&feel:

  onedark, eleline, devicons, startify, indentLine(with nerdfont),

* Color:

  Primary with tree-sitter from nvim nightly (nvim-lsp and this make it hard for me to turn back to vim)
  nvim-colorizer.lua (display hex and color in highlight), rainbow, log-highlight, limelight, interestingwords

* Git:

  fugitive, gv, defx-git

* Format:

  tabular, lsp based code formating (or, sometimes prettier), auto-pair

* Menu and tab:
  quickui(created a menu for the function/keybind I used less often. I can not remember all the commands and keybinds....)
  But Damn it, I spend lots of time to configure it, however, I rarely use it. So I end up delete the plugin. Check
  quickui in graveyard of how to use it.
  vim-buffet: wintab was one of the best buffer management tool. But vim-buffet is faster and just do the job.

* Tools: floatterm

* Move and Edit:

  easymotion, multi-cursor (has ome bugs with auto-complete. check this: [You don’t need more than one cursor in vim](https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db)
), vim-anyfold (better folding)

## Shell

* OMZshell is good, iterm2 is popular, but I turned to zprezto(with powerlevel10) + kitty. It is cooool and faster.
nvim+kitty split view:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/kitty.jpg)
