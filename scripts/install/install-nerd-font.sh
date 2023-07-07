curl https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$1.zip -fLo $1.zip
unzip $1.zip -d $1
rm $1.zip
