#!/usr/bin/env bash

PKGS=(
        'neofetch'              # CLI system info
        'cava'                  # CLI music visualizer
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done