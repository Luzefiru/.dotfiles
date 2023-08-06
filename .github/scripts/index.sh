#!/usr/bin/env bash
# this script was heavily inspired by the ArchMatic post-installation setup script: https://github.com/rickellis/ArchMatic

echo
echo
echo "  __                                     ___                           "
echo " /\ \                                  /'___\  __                      "
echo " \ \ \       __  __   ____       __   /\ \__/ /\_\    _ __   __  __    "
echo "  \ \ \  __ /\ \/\ \ /\_ ,'\   /'__'\ \ \ .__\\/\ \  /\ '__\/\ \/\ \   "
echo "   \ \ \L\ \\ \ \_\ \\/_/  /_ /\  __/  \ \ \_/ \ \ \ \ \ \/ \ \ \_\ \  "
echo "    \ \____/ \ \____/  /\____\\ \____\  \ \_\   \ \_\ \ \_\  \ \____/  "
echo "     \/___/   \/___/   \/____/ \/____/   \/_/    \/_/  \/_/   \/___/   "                                                                
echo
echo
echo "WARNING: This script will install & configure your Kubuntu system."
read -p "Do you want to proceed? (y/n) " yn

case $yn in 
	y ) echo Proceeding with installation...;;
	n ) echo Exiting ...;
		exit;;
	* ) echo Invalid response. Exiting...;
		exit 1;;
esac

echo
echo "[0] INITIALIZING APT PACKAGE MANAGER"
echo

cd $HOME
sudo apt update && sudo apt upgrade -y

echo
echo "Done!"
echo

echo
echo "[1] CORE SERVICES & UTILITIES"
echo

./setup-core.sh

echo
echo "Done!"
echo

echo
echo "[2] WEB BROWSER"
echo

echo "INSTALLING: brave-browser"
# script taken from: https://brave.com/linux/#debian-ubuntu-mint
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

echo
echo "Done!"
echo

echo
echo "[3] DEVELOPMENT ENVIRONMENT"
echo

./setup-dev.sh

echo
echo "Done!"
echo

echo
echo "[4] MISCELLANEOUS PACKAGES"
echo

./setup-misc.sh

echo
echo "Done!"
echo

echo
echo "[5] CLONING & CONFIGURING DOTFILES"
echo

./setup-dotfiles.sh

echo
echo "Done!"
echo

echo
echo "[6] CUSTOMIZING SHELL"
echo

./setup-zsh.sh

echo
echo "Done!"
echo

echo
echo "[7] DOWNLOADING KDE DESKTOP THEME & FONTS"
echo

./setup-theme.sh

echo
echo "Done!"
echo

echo
echo "[8] CHANGE SHELL & MANUAL REBOOT"
echo

echo
echo "Input your password to change default shell to zsh."
chsh -s /usr/bin/zsh

echo
echo "Done! You must reboot your computer to finalize the changes."
echo
