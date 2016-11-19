#!/bin/bash
for f in .*
do
    if [ "$f" = ".git" ]
    then
        continue
    fi
    echo "$(pwd)/$f"
    ln -s $(pwd)/$f ~/$f
done

sudo apt-get install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "DEFAULT_USER is: "
read DEFAULT_USER
echo $DEFAULT_USER > .zshrc
cd
git clone https://github.com/powerline/fonts
cd fonts
./install.sh

xrdb -load ~/.Xresources
