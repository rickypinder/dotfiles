alias gr='cd $(git rev-parse --show-top-level)' # this doesn't actually work

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/usr/local/bin:$PATH
export SOBOLE_THEME_MODE=dark
export SOBOLE_DEFAILT_USER=ricky

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



