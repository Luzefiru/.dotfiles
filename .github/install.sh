#!/usr/bin/env bash

cd ~/

sudo apt update && sudo apt upgrade
sudo apt install curl -y

curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/index.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/setup-dotfiles.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/clean-up.sh

chmod u+x index.sh setup-dotfiles.sh post-install.sh

./index.sh
