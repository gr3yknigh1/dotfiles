#
# ~/.bash_aliases
#

if [ -x /bin/fzf ]; then
    alias fcd='cd $(find . -type d -print | fzf)'
else
    alias fcd='echo "Error: "fzf" not installed"'
fi

if [ -x /bin/exa ]; then
    alias ls='exa --icons --group-directories-first $argv'
    alias l1='exa --icons -1 --group-directories-first $argv'
    alias ll='exa --icons -l --group-directories-first $argv'
    alias lt='exa --icons -T --group-directories-first $argv'
else
    alias ls='ls -X --color=auto --group-directories-first $argv'
    alias l1='ls -X --color=auto -1 --group-directories-first $argv'
    alias ll='ls -X --color=auto -l --group-directories-first $argv'
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

alias lg='lazygit'
alias e='nvim'
alias f='ranger'

alias apt='nala'

