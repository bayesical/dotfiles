#!/bin/bash

REPODIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
mkdir -p ~/.config
ln -s REPODIR/zsh/.zshrc ~/.zshrc
ln -s REPODIR/ohmyposh ~/.config/ohmyposh
ln -s REPODIR/nvim ~/.config/nvim
ln -s REPODIR/tmux/.tmux.conf ~/.tmux.conf

