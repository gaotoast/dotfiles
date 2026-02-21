#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

DOT_FILES=(.gitconfig .vimrc)

for file in "${DOT_FILES[@]}"; do
    src="$SCRIPT_DIR/$file"
    dest="$HOME/$file"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "skip: $dest (already linked)"
    elif [ -e "$dest" ]; then
        echo "skip: $dest (file already exists, remove it manually)"
    else
        ln -s "$src" "$dest"
        echo "linked: $dest -> $src"
    fi
done
