#
# ~/.bash_profile
#

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

PS1='\n\[\e[1;34m\] \w $ \[\e[0;37m\]'

### Python configuration
export VIRTUAL_ENV_DISABLE_PROMPT=1

_local_venv="$HOME/.local/venv"

# NOTE: Auto installing python "virtualenv"
# if [ -x /bin/python3 -a ! -d $_python_user_venv ]; then
#     /bin/python3 -m venv $_python_user_venv
# fi

if [ -d "$_local_venv/bin" ]; then
    PATH="$_local_venv/bin:$PATH"
fi

### Others

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

### Desktop

export XGD_CURRENT_DESKTOP=sway

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi

# Start Xorg Server
# if [ $(tty) = "/dev/tty1" ]; then
#     exec startx
# fi
