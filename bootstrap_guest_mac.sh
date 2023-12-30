#!/bin/bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

brew install kitty font-comic-shanns-mono-nerd-font helix lazygit

link_config() {
    local source target
    source="$PWD/$1"
    target="$HOME/.config/$(basename "$1")"

    if link=$(readlink "$target"); then
        if [[ "$link" == "$source" ]]; then
            echo "Already linked $target"
            return 0
        fi
    fi

    rm -rf "$target"
    ln -s "$source" "$target"
}

link_config config/kitty
link_config config/helix
