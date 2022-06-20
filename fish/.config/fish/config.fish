if status is-interactive
end

# -- EDITOR
set EDITOR "nvim"
alias e=$EDITOR

# -- CAT
alias cat="bat"

# -- LS
set LS_ALL true

function ls
    set -f LS_ALL_CHAR
    if $LS_ALL
        set -f LS_ALL_CHAR "-a"
    end
    exa $LS_ALL_CHAR --icons --group-directories-first
end

function l
    set -f LS_ALL_CHAR
    if $LS_ALL
        set -f LS_ALL_CHAR "-a"
    end
    exa $LS_ALL_CHAR -1 --icons --group-directories-first
end

function ll
    set -f LS_ALL_CHAR
    if $LS_ALL
        set -f LS_ALL_CHAR "-a"
    end
    exa $LS_ALL_CHAR -l --icons --group-directories-first
end

function lt
    set -f LS_ALL_CHAR
    if $LS_ALL
        set -f LS_ALL_CHAR "-a"
    end
    exa $LS_ALL_CHAR -T --icons --group-directories-first
end

