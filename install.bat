::
:: Install script for configurations. (Neovim only for now)
::
:: @file install.bat
:: @authors Ilya Akkuzin <gr3yknigh1@gmail.com>
:: @copyright (c) 2024, Ilya Akkuzin, all rights reserved
::

@echo off

set nvim_installation="%USERPROFILE%\AppData\Local\nvim"
set nvim_dist="%USERPROFILE%\.dotfiles\stows\nvim-v2\.config\nvim"

if exist %nvim_installation% (
    echo I: Neovim configuration already installed. Overwriting...
) else (
    echo I: No installation of neovim configration was found. Installing...
)

robocopy %nvim_dist% %nvim_installation% /E
