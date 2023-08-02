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

PKGS=(
        'git'                   # version control & interaction with repositories
        'rsync'                 # backup & SSH file transfer
        'curl'                  # make client http requests for other installers
        'wget'                  # same as above
        'openssh'               # ssh daemon
        'ca-certificates'       # certificate identity verification
        'gpg'                   # GNU privacy guard keys
        'apt-transport-https'   # access repositories with HTTPS
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

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

echo "INSTALLING: code"
# script taken from: https://brave.com/linux/#debian-ubuntu-mint
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install -y code

echo "INSTALLING: docker"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

PKGS=(
        'nodejs'                # javascript runtime engine
        'npm'                   # nodejs package manager
        'python3'               # python interpreter
        'python3-pip'           # python package manager
        'python3-venv'          # python virtual environment management
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

echo
echo "Done!"
echo

echo
echo "[4] MISCELLANEOUS PACKAGES"
echo

PKGS=(
        'neofetch'              # CLI system info
        'cava'                  # CLI music visualizer
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

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

PKGS=(
        'zsh'              # zsh interpreter
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

echo "INSTALLING: oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "INSTALLING: oh-my-zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "INSTALLING: p10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo
echo "Done!"
echo

echo
echo "[7] DOWNLOADING KDE DESKTOP THEME & FONTS"
echo

python3 -m venv ~/.venv
source ~/.venv/bin/activate
python -m pip install konsave

function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dotfiles pull
dotfiles reset --hard

source ~/.venv/bin/activate
konsave -a dev
konsave -a $THEME               # Konsave theme
fc-cache -f -v                  # refresh fonts

echo
echo "Done!"
echo

echo
echo "Input your password to change default shell to zsh."
chsh -s /usr/bin/zsh

echo
echo "Done! You must reboot your computer to finalize the changes."
echo
