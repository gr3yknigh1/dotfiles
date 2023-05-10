#
# ~/.bash_profile
#

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

PS1='\n\[\e[1;34m\] \w $ \[\e[0;37m\]'

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Start Xorg Server
if [ $(tty) = "/dev/tty1" ]; then
    exec startx
fi

