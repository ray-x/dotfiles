############################## zshrc ###############################################

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# Customize to your needs...

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
export GOPATH="/Users/ray.xu/go"
export GOROOT="/usr/local/opt/go/libexec"
# export GOPATH=$HOME/deltatre/go
# export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export GO111MODULE="on"
export PATH=~/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$GOROOT/bin:$PATH
export GOPRIVATE="bitbucket.org/appcurator"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.cargo/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias gvim='/usr/local/bin/mvim'
alias nv='/usr/local/bin/nvim'
alias nm='/usr/local/bin/nvim -u ~/github/dotfiles/init.min'
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
export TERM_ITALICS=true


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export TODO_DIR="$HOME/todo"
export KITTY_LISTEN_ON=unix:/tmp/mykitty-$PPID

autoload -Uz compinit && compinit
