#!/usr/bin/env sh
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
