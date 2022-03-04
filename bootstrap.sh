#!/bin/bash

if [[ -f /usr/bin/apt-get ]]; then
        sudo add-apt-repository ppa:neovim-ppa/stable
        sudo apt-get update
        sudo apt-get install neovim fzf tmux zsh ripgrep python3-venv
fi

git clone https://github.com/r-darwish/config-files ~/config-files
cd ~/config-files
zsh tmux/install.zsh
mkdir -p ~/.config
ln -s ~/config-files/nvim ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -f ~/.zshrc
ln -s ~/config-files/zshrc ~/.zshrc
~/config-files/install-zsh-plugins.zsh
chsh -s $(which zsh)
