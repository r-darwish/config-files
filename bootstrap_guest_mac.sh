#!/bin/bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"
source "common.zsh"

brew install kitty font-comic-shanns-mono-nerd-font helix lazygit

link_config config/kitty
link_config config/helix
