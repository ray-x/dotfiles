# vim as a programming IDE

I used to use slickedit, qt-creator, idea (webstorm, goland), vscode, but I am back to vi now. Thanks for `Dein.vim` I do
not need to configure my setup everytime....... I am still using sublime edit(as a notepad)

vimr is one of the best nvim-gui. But it does not in active development(It is hard for a one developer
project), some of the crash durning coding is annoying. I only use nvim(nightly) + kitty now.

The `Plug` config is located in branch [Plug branch](https://github.com/ray-x/dotfiles/tree/zprezto-plug)

* nvim+kitty configured with pop menu:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/menu.jpg)

* nvim clap preview:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/clap.jpg)

* nvim+kitty coc+ale:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/coc_float_errorcheck.jpg)


## Neovim Plugins
There are lots of amazing plugins,
I used following plugin a lots

* `Dein` -> `Lua-Packer`
   Dein is a great tool. Very fast and very well support for vim/neovim lazy loading. Change to Lua-Packer does not
   bring as great improvements as Plug -> Dein. But still about 80ms faster (~20%) for Golang codes loading.
   If you interested in Dein version, Please refer to [Dein](https://github.com/ray-x/dotfiles/tree/nvim-comple).
   This was the last Dein/Packer dual supports version I have (init.vim has a flag to choose).
   ATM, minium support for vim. Most plugins only works under neovim 0.5.0+.

   I am following Raphael(a.k.a glepnir) https://github.com/glepnir/nvim  dotfiles. He provides a good wrapper for
   Packer. I have an `overwrite` folder which will override the settings. Also, lots of changes in modules/plugins.
   A.T.M. nvim-comple as a completion engine with LSP, LSP saga. vim-multi-cursor, clap/telescope. treesitter,
   lazy load vim-go. So, other than module folder, I could copy/paste everything else from glepnir's configure file,
   which make my life easier.



* `Plug` -> `Dein`
   Plugin management tool.
   Plug is userfriendly. But the lazy is not as powerful as Dein. Also by default the cache system from Dein make it
   faster compared to Plug
   The configuration was optimized and lots of plugins are loaded lazily. Normally the startup time
   is around 150ms with 80% of plugins lazily loaded.
   Also tried packer.nvim. It is good, but is less popular and kind of buggy :(. Spended hours on it and
   still could not beat the performance of Dein. You could refer to my lua/plugins.lua for the packer setup.

* vim-clap

   One of the best plugin for search anything. I used it to replace fzf, leaderF, leaderP, defx, Ag/Ack/Rg, yank(ring), project management. undolist and many more.

* coc.nvim -> nvim-lsp

   I disabled vim-go auto-complete/LSP and turn to nvim-lsp. It adds around 200ms bootup time and some of the extensions
   might crash when I using coc (but it hard to check which becuase ~4 node.js services coc forked)
   Some useful script from TJ, and [glepnir](https://github.com/glepnir)

   nvim-tree: file-explorer (lightweight and fast)
   nvim-lua/completion-nvim: auto-complete
   vsnip: code snipts(Load snippet from VSCode extension). It is a full featured IDE.

   I put coc in graveyard. It works fine, but from time to time, there will be some dead node.js need to clean up manually.
   Also it is growing bigger and slower.......

   If you would like to enable coc, would be

   ```vim
 Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
 Plug 'vn-ki/coc-clap'
   ```
   The coc.vim and coc-settings.yml in graveyard folder is a good reference how to configure it.
   Replace defx with coc-explorer, use coc-spell(remove spelunker) for spell check
   coc-snippet replaced my ultisnips. Also, there are coc for yml, json, prettier, python, rust, PHP (any language vs code
   supported)......
   With Clap+coc and colorscheme(ray-x/paleaurora) setup.

* ALE

  Well, I am still using ALE and configure lint tools with it. It is good to find something compiler missed.

* Programming support:

  YCM (used to be my favourite, only for C++ and python now), but I am using lsp more offen now, primary using nvim-lsp for autocomplete and syntax check.
  vim-go(for go testing, highlight, gopls disabled), vsnipt, emmet-vim, Vista(function list with lsp), and some language specific plugins (e.g html, js/ts, swift),  tree-sitter with some cool AST highlight.

* Debug:

  vimspector, dlv

* Theme, look&feel:

  home cooked paleaurora, express-line (lua), devicons(lua), startify, indentLine(with nerdfont),

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

* OMZshell is good, iterm2 is popular, but I turned to zim(Zsh IMproved FrameWork
) + powerlevel10 + kitty. It is cooool and faster.
nvim+kitty split view:

    ![vim_ide with nvim+kitty](https://github.com/ray-x/dotfiles/blob/master/img/kitty.jpg)

zimfw is faster than oh-my-zh and zpreztor regarding the loading speed.
