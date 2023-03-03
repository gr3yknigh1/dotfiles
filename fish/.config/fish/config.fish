if status is-interactive
end

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

alias pacman="pacman --color=always"

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

if [ $(tty) = "/dev/tty1" ]
    startx
end

