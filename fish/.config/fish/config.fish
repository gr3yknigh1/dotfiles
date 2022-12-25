if status is-interactive
end

alias export="set -xg"

export FISH_CONFIG_DIR "$HOME/.config/fish"

alias ls="exa --icons --group-directories-first $argv"
alias l1="exa -1 --icons --group-directories-first $argv"
alias ll="exa -l --icons --group-directories-first $argv"
alias lt="exa -T --icons --group-directories-first $argv"

alias t="tmux"
alias tal="tmux attach"
alias ta="tmux attach -t"
alias tls="tmux ls"
alias tkr="tmux kill-server"
alias tks="tmux kill-session"

alias e="nvim"
alias f="ranger"
alias v="neovide"
alias lg="lazygit"

if [ $(tty) = "/dev/tty1" ]
    startx
end

