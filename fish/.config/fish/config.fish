if status is-interactive
end


alias cls="clear"
alias lg="lazygit"

# -- EDITOR
set EDITOR "nvim"
alias e=$EDITOR

# -- CAT
alias cat="bat"

alias ls="exa $LS_ALL_CHAR --icons --group-directories-first $argv"
alias l1="exa $LS_ALL_CHAR -1 --icons --group-directories-first $argv"
alias ll="exa $LS_ALL_CHAR -l --icons --group-directories-first $argv"
alias lt="exa $LS_ALL_CHAR -T --icons --group-directories-first $argv"

if [ $(tty) = "/dev/tty1" ]
    startx
end
