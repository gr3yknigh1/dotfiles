#
# ~/.bash_aliases
#

alias fcd='cd $(find . -type d -print | fzf)'

alias ls='exa --group-directories-first $argv'
alias l1='exa -1 --group-directories-first $argv'
alias ll='exa -l --group-directories-first $argv'
alias lt='exa -T --group-directories-first $argv'

alias t='tmux'
alias tal='tmux attach'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tkr='tmux kill-server'
alias tks='tmux kill-session'

alias lg='lazygit'
alias e='nvim'

alias pacman='pacman --color=always'

