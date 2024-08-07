#!/usr/bin/env zsh

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
source "common.zsh"

mkdir -p ~/.config

if [[ "$(uname)" == "Linux" ]]; then
    if type "apt-get" >/dev/null; then
        sudo apt-get update && sudo apt-get install -y build-essential
    fi

    if [[ ! -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -
    fi
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

for c in config/*; do
    link_config "$c"
done

for c in dynamic_config/*; do
    cp -r "$c" ~/.config
done

rm -f ~/.zshrc
ln -s "$PWD/zshrc" ~/.zshrc
git config --global include.path "$PWD/.gitconfig"

test -d ~/.antidote || git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh
for c in zsh/*.txt; do
    zsh_file="${c:r}.zsh"
    antidote bundle <"$c" >"$zsh_file" || true
done
if [[ -n "$BACKGROUND" ]]; then
    HOMEBREW_NO_INSTALL_CLEANUP=TRUE brew install starship atuin lsd zellij yazi fzf zoxide neovim || true
    echo "Running package installation in the background"
    nohup brew bundle install >/tmp/brew.log 2>&1 &
else
    brew bundle install
fi

gen_zsh="gen.zsh"
echo "" >"$gen_zsh"

if type "starship" >/dev/null; then
    starship init zsh >>"$gen_zsh"
fi

if type "zoxide" >/dev/null; then
    zoxide init zsh >>"$gen_zsh"
fi

if type "fzf" >/dev/null; then
    fzf --zsh >>"$gen_zsh"
fi

if type "atuin" >/dev/null; then
    atuin init zsh >>"$gen_zsh"
fi
