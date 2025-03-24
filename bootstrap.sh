#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
source "common.zsh"

mkdir -p ~/.config

if [[ "$(uname)" == "Linux" ]]; then
    if type "apt-get" >/dev/null; then
        if ! type "gcc" >/dev/null; then
            sudo apt-get update && sudo apt-get install -y build-essential
        fi

        if [[ ! -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
            curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
fi

for c in config/*; do
    link_config "$c"
done
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"

for c in dynamic_config/*; do
    cp -r "$c" ~/.config
done

git config --global include.path "$PWD/.gitconfig"

if type "brew" >/dev/null; then
    if [[ -n "$BACKGROUND" ]]; then
        export HOMEBREW_NO_INSTALL_CLEANUP=TRUE
        brew tap rsteube/homebrew-tap || true
        brew install nushell starship atuin zoxide neovim rsteube/tap/carapace || true
        echo "Running package installation in the background"
        nohup brew bundle install >/tmp/brew.log 2>&1 &
    else
        brew bundle install
    fi
fi

if [[ -d "$HOME/wiz-sec" ]]; then
    [[ -d "$HOME/wiz-sec/darwish" ]] || git clone https://github.com/wiz-sec/darwish "$HOME/wiz-sec/darwish"
    [[ -d "$HOME/wiz-sec/dotfiles" ]] || git clone https://github.com/wiz-sec/dotfiles "$HOME/wiz-sec/dotfiles"
fi

./bootstrap.nu
