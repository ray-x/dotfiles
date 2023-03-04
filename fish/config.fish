
#  https://fishshell.com/docs/current/index.html

set fish_greeting
set os (uname)


# never checkin this part
#
set -gx  LOCALSTACK_API_KEY	5idHUizXpE
# never and ever


# Environment variables - https://fishshell.com/docs/current/cmds/set.html
set -gx EDITOR 'nvim'
set -gx BUNDLER_EDITOR $EDITOR
set -gx MANPAGER 'less -X' # Don’t clear the screen after quitting a manual page
set -gx HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -gx SOURCE_ANNOTATION_DIRECTORIES 'spec'
set -gx RUBY_CONFIGURE_OPTS '--with-opt-dir=/usr/local/opt/openssl:/usr/local/opt/readline:/usr/local/opt/byaml:/usr/# local/opt/gdbm'
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx DOTFILES "$HOME/github/dotfiles"
set -gx __NV_PRIME_RENDER_OFFLOAD "1"
set -gx __GLX_VENDOR_LIBRARY_NAME "nvidia"
set -gx RIPGREP_CONFIG_PATH "$DOTFILES/ripgreprc"
# set -gx HOST_NAME (scutil --get HostName)


# FZF specific - https://github.com/junegunn/fzf#key-bindings-for-command-line
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --no-ignore-vcs'
set -gx FZF_DEFAULT_OPTS '--height 50% --layout=reverse --border'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d . --color=never'
set -gx FZF_PREVIEW_COLUMNS (math ceil $COLUMNS \* 0.75)
set -gx FORGIT_DIFF_FZF_OPTS "--exit-0 --preview-window='right:70%'"
#
#
#
set -gx GOPATH $HOME/go $HOME/projects
# set -gx GOROOT "/usr/local/opt/go/libexec" # install with brew

# set -gx GOROOT "/usr/local/go"   # install with brew pkg download from golang.org
set -gx GOROOT "/usr/lib/go"
set -gx GOHOME $HOME/go
set -gx GOBIN $HOME/go/bin
set -gx GO111MODULE "on"

set -gx PATH ~/bin /usr/local/bin $HOME/.local/bin $PATH
fish_add_path /usr/local/opt/curl/bin
set -gx PATH $GOPATH/bin $PATH
set -gx PATH $GOROOT/bin $PATH
set -gx GOPRIVATE "bitbucket.org/*,frankieone.dev/*,github.com/frankieone/*"

# set -gx GO2GO_DEST $GOPATH/src/github.com/go2
# set -gx PATH $GO2GO_DEST/bin $PATH
# set -gx GOROOT "$GO2GO_DEST"
# set -gx GO2PATH "$GO2GO_DEST/src/cmd/go2go/testdata/go2path"

# set -gx PASSWORD_STORE_DIR $HOME/github/dotfiles/pass
# set -gx GNUPGHOME $HOME/github/dotfiles/gnupg

# set -gx GIT_AUTHOR_NAME  (pass show del_ml|cut -d@ -f1)
# set -gx GIT_AUTHOR_EMAIL (pass show del_ml)
# set -gx GIT_COMMITTER_NAME (pass show del_ml|cut -d@ -f1)
# set -gx GIT_COMMITTER_EMAIL (pass show del_ml)

set -gx PATH $HOME/.deno/bin $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $HOME/.cargo/bin $PATH
set -gx NVM_DIR "$HOME/.nvm"
# # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias gvim='/usr/local/bin/mvim'
alias nv='/usr/local/bin/nvim'
alias vi='/usr/local/bin/nvim'
alias vdiff='/usr/local/bin/nvim -d -u ~/github/dotfiles/init.min'
alias gdv='git difftool --tool gvimdiff'
alias nd='git difftool --tool nvimdiff'
alias ls='exa'
alias ll='exa -alh'
alias rtl='exa -alh -s mod'
alias tree='exa --tree'
alias icat "kitty +kitten icat"
alias cat='bat -p'
alias RM='/bin/rm'
alias gtest='richgo test ./... -count=1 -p=1'
set -gx PATH /usr/local/opt/python@3.9/bin $PATH
set -gx PATH /usr/local/opt/llvm/bin $HOME/github/dotfiles/bin/ $PATH
set -gx PATH /home/ray/.local/share/gem/ruby/3.0.0/bin $PATH
#
# # Completion for kitty
# kitty + complete setup fish | source. #fish earlier than 3.0.0,
set -gx TERM_ITALICS true
#
#
# set -gx KITTY_LISTEN_ON "unix:/tmp/mykitty-$PPID"
set -gx SKIM_DEFAULT_COMMAND "fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."

# alias fzf='fzf --preview "bat {} --color=always"'
alias fzb='fzf --preview "bat {} --color=always"'
# alias sk='sk --preview "bat {} --color=always"'  #sk not maintained
# alias seperator="viu `echo ~/photos/$(ls ~/photos |sort -R |tail -1)`'

alias seperator='viu (echo $HOME"/photos/"(ls ~/photos |sort -R |tail -1))'
alias rm='trash-put'

set -gx JAR $HOME/lsp_test/jdt-language-server-1.3.0-202108171748/plugins/# # eclipse.equinox.launcher_1.6.100.v20201223-0822.jar
set -gx GRADLE_HOME $HOME/gradle

if test $os = 'Linux'
  set -gx HOST_NAME RayLinux
  set -gx JAVA_HOME /usr/lib/jvm/java-18-openjdk/
  set -gx JDTLS_HOME $HOME/lsp_test/jdt-language-server-1.3.0-202108171748
  set -gx JDTLS_CONFIG $JDTLS_HOME/config_mac
else
  set -gx HOST_NAME RayMac
  set -gx JAVA_HOME /usr/local/Cellar/openjdk/17.0.1/
  set -gx JDTLS_HOME $HOME/lsp_test/jdt-language-server-1.3.0-202108171748
  set -gx JDTLS_CONFIG $JDTLS_HOME/config_mac
end

set -gx WORKSPACE $HOME/workspace

set -gx PATH $PATH JAVA_HOME/bin $HOME/software/kafka/kafka_2.11-2.3.0/bin

# set -gx SHELL /bin/bash
#
#
#
# 	fish_vi_key_bindings
fish_default_key_bindings -M insert
fish_vi_key_bindings --no-erase insert
# bind \ca beginning-of-line
# bind \ce end-of-line
bind --mode insert \ce end-of-line
bind --mode insert \ca beginning-of-line
if status is-interactive
  # source $XDG_CONFIG_HOME/fish/abbreviations.fish

  # https://github.com/starship/starship#fish
  starship init fish | source
  zoxide init fish | source
  # z.lua
  # lua $HOME/bin/z --init fish | source

  # https://asdf-vm.com/#/core-manage-asdf-vm?id=add-to-your-shell
  # source ~/.asdf/asdf.fish


  #set theme_color_scheme gruvbox

  # set -l onedark_options '-b'

  # set_onedark $onedark_options
  # theme_gruvbox dark
  source $XDG_CONFIG_HOME/fish/conf.d/fish_tokyonight_storm.fish

end
fish_add_path /usr/local/opt/ruby/bin
fish_add_path /usr/local/lib/ruby/gems/3.0.0/bin
if status is-login
  ssh-add
end

alias cmdhis "_fzf_search_history"
# pnpm
set -gx PNPM_HOME "/home/ray/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
#
set -gx NPM_TOKEN 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
set -x PATH "$HOME/github/dotfiles/fish/plugins/git-fuzzy/bin:$PATH"
set sponge_purge_only_on_exit true

function rgn -d "grep preview and edit with nvim"
  # rg -n $argv | fzf --delimiter=':' --preview 'bat --color=always {1} --line-range {2}:+20' | cut -d ':' -f1 | xargs -r nvim
  rg -n $argv | fzf --delimiter=':' --preview 'bat --color=always {1} --line-range {2}:+20' | awk -F ':' '{print "+" $2 " " $1}' | xargs nvim
end

function fdn -d "fd preview and edit with nvim"
  fd --full-path $argv | fzf --delimiter=':' --preview 'bat --color=always {1} --line-range {2}:+20' | cut -d ':' -f1 | xargs -r nvim
end
