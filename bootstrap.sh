#!/bin/bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

mkdir -p ~/.config

link_config() {
    local source target
    source="$PWD/$1"
    target="$HOME/.config/$(basename $1)"

    if link=$(readlink "$target"); then
        if [[ "$link" == "$source" ]]; then
            echo "Already linked $target"
            return 0
        fi
    fi

    rm -rf "$target"
    ln -s "$source" "$target"
}

for c in config/*; do
    link_config "$c"
done

for c in dynamic_config/*; do
        cp -r "$c" ~/.config
done

rm -f ~/.zshrc; ln -s "$PWD/zshrc" ~/.zshrc
git config --global include.path "$PWD/.gitconfig"
