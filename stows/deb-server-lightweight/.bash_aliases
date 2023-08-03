#
# ~/.bash_aliases
#

alias ls='ls --group-directories-first $argv'
alias l1='ls -1 --group-directories-first $argv'
alias ll='ls -l --group-directories-first $argv'

if [ -x /bin/tree ]; then
    alias lt='tree --dirsfirst $argv'
fi

if [ -x /bin/tmux ]; then
    alias t='tmux'
    alias tal='tmux attach'
    alias ta='tmux attach -t'
    alias tls='tmux ls'
    alias tkr='tmux kill-server'
    alias tks='tmux kill-session'
fi

alias e='vim'

