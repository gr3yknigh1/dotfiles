if status is-interactive
end

# TODO: Replace aliases with function calls

if [ -x "$(which exa)" ]
    alias ls="exa --icons --group-directories-first $argv"
    alias l1="exa -1 --icons --group-directories-first $argv"
    alias ll="exa -l --icons --group-directories-first $argv"
    alias lt="exa -T --icons --group-directories-first $argv"
    alias lt2="exa -T -L 2 --icons --group-directories-first $argv"
    alias lt3="exa -T -L 3 --icons --group-directories-first $argv"
else
    alias ls="ls --group-directories-first $argv"
    alias l1="ls -1  --group-directories-first $argv"
    alias ll="ls -l --group-directories-first $argv"
    
    if [ -x "$(which tree)" ]
        alias lt="tree --dirsfirst $argv"
        alias lt2="tree -L 2 --dirsfirst $argv"
        alias lt3="tree -L 3 --dirsfirst $argv"
    end
end


if [ -x "$(which bat)" ]
    alias cat="bat --theme gruvbox-dark"
end

if [ -x "$(which batcat)" ]
    alias cat="batcat --theme gruvbox-dark"
end

if [ -x "$(which tmux)" ]
    alias t="tmux"
    alias tal="tmux attach"
    alias ta="tmux attach -t"
    alias tls="tmux ls"
    alias tkr="tmux kill-server"
    alias tks="tmux kill-session"
end

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
