# Fish shell installation note

You should change default shell with this command:

```shell
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
```

