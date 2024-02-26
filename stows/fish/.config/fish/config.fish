if status is-interactive
end

# TODO: Handle lack of exa on system
alias ls="exa --icons --group-directories-first $argv"
alias l1="exa -1 --icons --group-directories-first $argv"
alias ll="exa -l --icons --group-directories-first $argv"
alias lt="exa -T --icons --group-directories-first $argv"
alias lt2="exa -T -L 2 --icons --group-directories-first $argv"
alias lt3="exa -T -L 3 --icons --group-directories-first $argv"

# TODO: Handle Debian and Arch aliases for bat | batcat
alias cat="batcat --theme gruvbox-dark"

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

pyenv init - | source

set -g PATH "$HOME/go/bin:$PATH"
set -g PATH "$HOME/.cargo/bin:$PATH"

set -g VIRTUAL_ENV_DISABLE_PROMPT 1

pyenv init - | source

# FZF Plugin
set -g EDITOR nvim

# NOTE: Start XOrg session
# if [ $(tty) = "/dev/tty1" ]
#     startx
# end


set -g DEBUGINFOD_URLS "https://debuginfod.archlinux.org/"
