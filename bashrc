#
# ~/.bashrc
#

BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
MAGENTA="\e[0;35m"
CYAN="\e[0;36m"
LGRAY="\e[0;37m"
DGRAY="\e[1;37m"
LRED="\e[1;31m"
LGREEN="\e[1;32m"
LYELLOW="\e[1;33m"
LBLUE="\e[1;34m"
LMAGENTA="\e[1;35m"
LCYAN="\e[1;36m"
WHITE="\e[0;97m"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

#default ps1:
#PS1='[\u@\h \W]\$ '
PS1="${LGRAY}┌╼[${WHITE}\t${LGRAY}]╾╼[${YELLOW}\u${LGRAY}]╾╼[${BLUE}\w${LGRAY}]\n└─╼[${GREEN}\$${LGRAY}]${WHITE} » "

