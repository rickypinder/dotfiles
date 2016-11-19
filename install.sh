#!/bin/bash

sudo apt-get install zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s $(which zsh)
rm ~/.zshrc
cd
git clone https://github.com/powerline/fonts
cd fonts
./install.sh

for f in .*
do
    if [ "$f" = ".git" ]
    then
        continue
    fi
    echo "$(pwd)/$f"
    ln -s $(pwd)/$f ~/$f
done

xrdb -load ~/.Xresources
