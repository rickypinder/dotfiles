# this doesn't actually work
alias gr='cd $(git rev-parse --show-top-level)'

alias et='emacsclient -t'
alias emacskill='emacsclient -e "(kill-emacs)"'

function ec() {
    emacsclient -c "$1" &
}

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/usr/local/bin:$PATH
export SOBOLE_THEME_MODE=dark
export SOBOLE_DEFAILT_USER=ricky
export ALTERNATE_EDITOR=""

source /usr/local/share/antigen/antigen.zsh
autoload -U colors && colors
setopt promptsubst

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle sobolenv/sobole-zsh-theme

antigen theme sobolevn/sobole-zsh-theme

antigen apply



