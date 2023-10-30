if status is-interactive
end

alias ls="exa --icons --group-directories-first $argv"
alias l1="exa -1 --icons --group-directories-first $argv"
alias ll="exa -l --icons --group-directories-first $argv"
alias lt="exa -T --icons --group-directories-first $argv"
alias lt2="exa -T -L 2 --icons --group-directories-first $argv"
alias lt3="exa -T -L 3 --icons --group-directories-first $argv"

if [ -x "$(which batcat)" ]
    alias cat="batcat"
end

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

set -g PATH "$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


set -g PATH "$HOME/go/bin:$PATH"
set -g PATH "$HOME/.cargo/bin:$PATH"

set -e VIRTUAL_ENV_DISABLE_PROMPT 0

# FZF Plugin
set -g EDITOR nvim

# NOTE: Start XOrg session
# if [ $(tty) = "/dev/tty1" ]
#     startx
# end

