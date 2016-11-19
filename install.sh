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

xrdb -load ~/.Xresources
cd
git clone https://github.com/powerline/fonts
cd fonts
./install.sh
