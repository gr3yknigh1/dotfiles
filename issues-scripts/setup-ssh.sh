ssh-keygen -C "gr3yknigh1@gmail.com"
xclip -selection clipboard ~/.ssh/id_rsa.pub
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

