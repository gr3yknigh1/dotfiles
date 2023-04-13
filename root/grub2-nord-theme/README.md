# Fork of grub2-themes inspired by nord theme.
[nordtheme.com](https://www.nordtheme.com/)

## Installation:

Usage:  `sudo ./install.sh [OPTIONS...]`

|  Options:              | Description: |
|:-----------------------|:-------------|
| -b, --boot             | Install grub theme into `/boot/grub/themes` |
| -s, --screen           | screen resolution variant(s) [1080p/2k/4k/ultrawide/ultrawide2k] (default is 1080p)"
| -r, --remove [THEME]   | Uninstall selected theme |
| -h, --help             | Show this help |

_If no options are used, a user interface `dialog` will show up instead_

### Examples:
 - Install 2k display device:
   - `sudo ./install.sh -s 2k`

 - Install into /boot/grub/themes:
   - `sudo ./install.sh -b`

 - Uninstall theme:
   - `sudo ./install.sh -r`

## Issues / tweaks:

### Correcting display resolution:

 - On the grub screen, press `c` to enter the command line
 - Enter `vbeinfo` or `videoinfo` to check available resolutions
 - Open `/etc/default/grub`, and edit `GRUB_GFXMODE=[height]x[width]x32` to match your resolution
 - Finally, run `grub-mkconfig -o /boot/grub/grub.cfg` to update your grub config

### Setting a custom background:

 - Make sure you have `imagemagick` installed, or at least something that provides `convert`
 - Find the resolution of your display, and make sure your background matches the resolution
   - (1920x1080 -> --1080p, 2560x1080 -> --ultrawide, 2560x1440 -> --2k, 3440x1440 -> --ultrawide2k, 3840x2160 -> --4k)
 - Place your custom background inside the root of the project, and name it `background.jpg`
 - Run the installer like normal, but with -s `[YOUR_RESOLUTION]` and -t `[THEME]` and -i `[ICON]`
   - Make sure to replace `[YOUR_RESOLUTION]` with your resolution and `[THEME]` with the theme

## Preview:
Images shown: tela/vimix/stylish/whitesur
![preview](preview.png?raw=true)

## Documents

[Grub2 theme reference](http://wiki.rosalab.ru/en/index.php/Grub2_theme_/_reference)

[Grub2 theme tutorial](http://wiki.rosalab.ru/en/index.php/Grub2_theme_tutorial)
