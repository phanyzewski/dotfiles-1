#!/bin/bash

echo "Interactively linking dotfiles into ~..."
./link-dotfiles.sh

echo "Installing Homebrew packages..."
brew bundle

echo "Installing Vim packages..."
git clone git@github.com:gmarik/Vundle.vim.git ./vim/bundle/Vundle.vim
vim +BundleInstall +qa

echo "If you like what you see in system/osx-settings, run ./system/osx-settings"
