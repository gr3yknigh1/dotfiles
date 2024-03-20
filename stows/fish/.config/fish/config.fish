if status is-interactive
end

function has_executable
    if [ -x "$(which $argv 2> /dev/null)" ]
        echo 1
        return 1
    end
    return 0
end

function cond_alias
    set exec_ $argv[1]
    set alias_ $argv[2]

    if [ $(has_executable $exec_) ]
        alias $alias_ $exec_
    end
end

set -g LAUNCH_XORG_ON_STARTUP no

set -g USE_FUNC_ALIASES yes
set -g BATCAT_THEME gruvbox-dark
set -g VIRTUAL_ENV_DISABLE_PROMPT 1

set -g DEBUGINFOD_URLS "https://debuginfod.archlinux.org/"

set -g PATH "$HOME/go/bin:$PATH"
set -g PATH "$HOME/.cargo/bin:$PATH"

set -u EDITOR nvim

if [ $USE_FUNC_ALIASES = "yes" ] 

    function ls
        if [ $(has_executable exa) ]
            exa --icons --group-directories-first $argv
        else
            ls --group-directories-first $argv
        end
    end

    function l1
        if [ $(has_executable exa) ]
            exa -1 --icons --group-directories-first $argv
        else
            ls -1  --group-directories-first $argv
        end
    end

    function ll
        if [ $(has_executable exa) ]
            exa -l --icons --group-directories-first $argv
        else
            ls -l --group-directories-first $argv
        end
    end

    function lt
        if [ $(has_executable exa) ]
            exa -T --icons --group-directories-first $argv
        else
            tree --dirsfirst $argv
        end
    end

    function lt2
        if [ $(has_executable exa) ]
            exa -T -L 2 --icons --group-directories-first $argv
        else
            tree -L 2 --dirsfirst $argv
        end
    end

    function lt3
        if [ $(has_executable exa) ]
            exa -T -L 3 --icons --group-directories-first $argv
        else
            tree -L 3 --dirsfirst $argv
        end
    end

    function cat
        echo 1
        if [ $(has_executable bat) ]
            bat --theme $BATCAT_THEME $argv
        else if [ $(has_executable batcat) ]
            batcat --theme $BATCAT_THEME $argv
        end
    end
else
    if [ $(has_executable exa) ]
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
        
        if [ $(has_executable tree) ]
            alias lt="tree --dirsfirst $argv"
            alias lt2="tree -L 2 --dirsfirst $argv"
            alias lt3="tree -L 3 --dirsfirst $argv"
        end
    end

    if [ $(has_executable bat) ]
        alias cat="bat --theme $BATCAT_THEME"
    else if [ $(has_executable batcat) ]
        alias cat="batcat --theme gruvbox-dark"
    end
end

if [ $(has_executable tmux) ]
    alias t="tmux"
    alias tal="tmux attach"
    alias ta="tmux attach -t"
    alias tls="tmux ls"
    alias tkr="tmux kill-server"
    alias tks="tmux kill-session"
end

cond_alias nvim      e
cond_alias ranger    f
cond_alias neovide   v
cond_alias lazygit   lg

if [ $(has_executable pyenv) ]
    pyenv init - | source
end

if [ $LAUNCH_XORG_ON_STARTUP = "yes" ] && [ $(has_executable startx) ]
    if [ $(tty) = "/dev/tty1" ]
        startx
    end
end


