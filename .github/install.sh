#!/usr/bin/env bash
THEME=dev

cd ~/

sudo apt update && sudo apt upgrade
sudo apt install curl -y

curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/index.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/setup-core.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/setup-dev.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/setup-misc.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/setup-dotfiles.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/setup-zsh.sh
curl -O https://raw.githubusercontent.com/Luzefiru/.dotfiles/main/.github/scripts/setup-theme.sh

chmod u+x index.sh setup-core.sh setup-dev.sh setup-misc.sh setup-zsh.sh setup-dotfiles.sh setup-theme.sh

./index.sh

rm index.sh setup-core.sh setup-dev.sh setup-misc.sh setup-zsh.sh setup-dotfiles.sh setup-theme.sh