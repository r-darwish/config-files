#!/bin/bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"
source "common.zsh"

sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix

link_config config/helix

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
