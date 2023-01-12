# dotfiles

In order to install configs, you must install GNU Stow.

Install config example:

```bash
stow -S lua-nvim
```

More explicit version:

```bash
stow -S lua-nvim -d . -t ~
```
