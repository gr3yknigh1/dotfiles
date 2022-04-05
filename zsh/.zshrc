# Use powerline
USE_POWERLINE="false"

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

alias e="nvim"
alias cls="clear"

# Add .NET Core SDK tools
export PATH="$PATH:/root/.dotnet/tools"
export DOTNET_ROOT=/snap/dotnet-sdk/current

