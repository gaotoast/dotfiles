#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

DOT_FILES=(
    .gitconfig
    .vimrc
    .claude/settings.json
    .claude/statusline-command.sh
)

for file in "${DOT_FILES[@]}"; do
    src="$SCRIPT_DIR/$file"
    dest="$HOME/$file"

    dest_dir=$(dirname "$dest")
    if [ ! -d "$dest_dir" ]; then
        mkdir -p "$dest_dir"
        echo "created dir: $dest_dir"
    fi

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "skip: $dest (already linked)"
    elif [ -e "$dest" ]; then
        echo "skip: $dest (file already exists, remove it manually)"
    else
        ln -s "$src" "$dest"
        echo "linked: $dest -> $src"
    fi
done
