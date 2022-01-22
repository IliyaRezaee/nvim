#! /usr/bin/sh

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
./extensions.sh
