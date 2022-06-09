if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cat="batcat"
alias ls="exa --icons --group-directories-first"
alias l="exa -1 --icons --group-directories-first"
alias ll="exa -l --icons --group-directories-first"
alias la="exa -a --icons --group-directories-first"
alias lla="exa -la --icons --group-directories-first"
alias lt="exa -T --icons --group-directories-first"

# if -n "$NVIM_LISTEN_ADDRESS"
#     alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
# end
#
# if -n "$NVIM_LISTEN_ADDRESS"
#     export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
#     export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
# else
#     export VISUAL="nvim"
#     export EDITOR="nvim"
# end
