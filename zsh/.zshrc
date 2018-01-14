# this doesn't actually work
alias gr='cd $(git rev-parse --show-top-level)'
alias ctags="`brew --prefix`/bin/ctags"

alias et='emacsclient -t'
alias emacskill='emacsclient -e "(kill-emacs)"'

function ec() {
    if [ -z $1 ]; then
        emacsclient -c &
    else
        emacsclient -c "$1" &
    fi
}

alias pg='ping -c 5 8.8.8.8'

alias vim='mvim -v'

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/usr/local/bin:$PATH
export SOBOLE_THEME_MODE=dark
export SOBOLE_DEFAILT_USER=ricky
export ALTERNATE_EDITOR=""

source /usr/local/share/antigen/antigen.zsh
autoload -U colors && colors
setopt promptsubst

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply



