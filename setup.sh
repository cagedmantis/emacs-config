#!/bin/sh
#
# Copies files to the emacs configuration directory.

EMACSHOME=~/.emacs.d

echo $EMACSHOME

if [ -d ~/.emacs.d ]; then
    echo "Archiving current emacs directory."
    mv $EMACSHOME $EMACSHOME$(date +%Y%m%d-%H-%M)
fi

echo "Creating emacs configuration directory: $EMACSHOME"
mkdir $EMACSHOME

echo "Copying this repository."
cp -r ./ $EMACSHOME
