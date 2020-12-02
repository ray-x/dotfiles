# Use ~~ as the trigger sequence instead of the default **
# export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

# usage: _fzf_setup_completion path|dir|var|alias|host COMMANDS...
# _fzf_setup_completion path ag git kubectl
# _fzf_setup_completion dir tree

# Custom fuzzy completion for "doge" command
#   e.g. doge **<TAB>
_fzf_complete_doge() {
  _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}


# FZF_DEFAULT_COMMAND='ps -ef' \
#   fzf --bind 'ctrl-r:reload($FZF_DEFAULT_COMMAND)' \
#       --header 'Press CTRL-R to reload' --header-lines=1 \
#       --height=50% --layout=reverse

# FZF_DEFAULT_COMMAND='find . -type f' \
#   fzf --bind 'ctrl-d:reload(find . -type d),ctrl-f:reload($FZF_DEFAULT_COMMAND)' \
#       --height=50% --layout=reverse

# INITIAL_QUERY=""
# RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
# FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
#   fzf --bind "change:reload:$RG_PREFIX {q} || true" \
#       --ansi --phony --query "$INITIAL_QUERY" \
#       --height=50% --layout=reverse

# export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'

# install fzf extra git clone https://github.com/atweiden/fzf-extras ~/.fzf-extras

OPENER=open

[[ -e "$HOME/.fzf-extras/fzf-extras.zsh" ]] \
 && source "$HOME/.fzf-extras/fzf-extras.zsh"

[[ -e "$HOME/github/wfxr/forgit/forgit.plugin.zsh" ]] \
 && source "$HOME/github/wfxr/forgit/forgit.plugin.zsh"


[[ -e "$HOME/github/Aloxaf/fzf-tab/fzf-tab.zsh" ]] \
 && source "$HOME/github/Aloxaf/fzf-tab/fzf-tab.zsh"

zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# not really helpful
export PATH=$PATH:$HOME/github/DanielFGray/fzf-scripts/
