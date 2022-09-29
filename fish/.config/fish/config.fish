if status is-interactive
end

set EDITOR "nvim"

alias cls="clear"
alias lg="lazygit"
alias misha="gcc"

alias e=$EDITOR

alias cat="bat"

alias ls="exa $LS_ALL_CHAR --icons --group-directories-first $argv"
alias l1="exa $LS_ALL_CHAR -1 --icons --group-directories-first $argv"
alias ll="exa $LS_ALL_CHAR -l --icons --group-directories-first $argv"
alias lt="exa $LS_ALL_CHAR -T --icons --group-directories-first $argv"

alias t="tmux"
alias tal="tmux attach"
alias ta="tmux attach -t"
alias tls="tmux ls"
alias tkr="tmux kill-server"
alias tks="tmux kill-session"


# start x-server
if [ $(tty) = "/dev/tty1" ]
    startx
end

