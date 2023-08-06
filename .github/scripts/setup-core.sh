#!/usr/bin/env bash

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