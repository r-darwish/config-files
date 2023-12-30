#!/bin/bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"
source "common.zsh"

sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix

link_config config/helix
