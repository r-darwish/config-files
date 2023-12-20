#!/bin/bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

mkdir -p ~/.config

if [[ "$(uname)" == "Linux" ]]; then
    if ! command -v brew &>/dev/null; then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

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

for c in config/*; do
    link_config "$c"
done

for c in dynamic_config/*; do
    cp -r "$c" ~/.config
done

rm -f ~/.zshrc
ln -s "$PWD/zshrc" ~/.zshrc
git config --global include.path "$PWD/.gitconfig"
test -f ~/.antidote || git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
make -C zsh
brew bundle install
