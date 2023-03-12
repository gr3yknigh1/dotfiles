repos=('the-sharpest-one' 'gremlin-murphy' 'godot-mono-custom-script-register' 'godot-code-generator' 'nuclear-beer-factory' 'dinofication')

for repo in ${repos[@]}
do
    if [ -d $repo ] ; then
        echo $repo "- already exists"
        continue
    fi
    git clone git@github.com:drunken-beear-team/$repo
done


for repo in ${repos[@]}
do
    cd $repo
    git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
    git fetch --all
    git pull --all
    cd ".."
done
