#!/bin/bash

# This script cycles through the dotfiles and systemlinks to the home directory

for f in *
do
    if [ "$f" = ".git" ] || [ "$f" = "." ] || [ "$f" =  ".." ] || [ "$f" = "install.sh" ] || [ "$f" = "misc" ]
    then
        continue
    fi
    echo "$(pwd)/$f"
    ln -s $(pwd)/$f ~/$f
done

