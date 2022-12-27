# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fwalch"

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled  # disable automatic updates

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy/mm/dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias clip="xclip -selection clipboard $argv"

alias pacman="pacman --color=always"

alias ls="exa --icons --group-directories-first $argv"
alias l1="exa -1 --icons --group-directories-first $argv"
alias ll="exa -l --icons --group-directories-first $argv"
alias lt="exa -t --icons --group-directories-first $argv"

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


if [ $(tty) = "/dev/tty1" ] ; then
    startx
fi
