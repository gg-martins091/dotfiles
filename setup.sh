#!/bin/sh

sudo apt install fonts-powerline ripgrep
ln -s -f ~/dotfiles/nvim ~/.config/nvim
ln -s ./terminator/config ~/.config/terminator/config

if [[ "$(uname)" == "Darwin" ]]; then
	ln -s ./tmux/.tmux.conf.darwin ~/.tmux.conf
else
	ln -s ./tmux/.tmux.conf ~/.tmux.conf
fi
