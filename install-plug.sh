#!/usr/bin/env bash

set -e
cd "$(dirname $0)"

rm -rf ~/.local/share/nvim ~/.local/state/nvim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
