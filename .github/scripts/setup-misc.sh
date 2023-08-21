#!/usr/bin/env bash

PKGS=(
        'neofetch'              # CLI system info
        'cava'                  # CLI music visualizer
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

echo "INSTALLING: syncthing"
# script taken from: https://apt.syncthing.net/
sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt update
sudo apt install -y syncthing

echo "Starting syncthing@$(whoami) service..."
sudo systemctl start syncthing@$(whoami)
sudo systemctl enable syncthing@$(whoami)