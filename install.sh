#!/bin/bash
for f in .*
do
    echo "$(pwd)/$f"
    ln -s $(pwd)/$f ~/$f
done
