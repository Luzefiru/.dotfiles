#!/usr/bin/env bash

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
sudo usermod -aG docker $USER

echo "INSTALLING: kubectl"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
echo 'source <(kubectl completion bash)' >> ~/.zshrc

echo "INSTALLING: k3d"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

PKGS=(
        'nodejs'                # javascript runtime engine
        'npm'                   # nodejs package manager
        'python3'               # python interpreter
        'python3-pip'           # python package manager
        'python3-venv'          # python virtual environment management
        'default-jdk'           # java dev kit with the jre
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

echo "Setting up JAVA_HOME env variable in /etc/environment..."
sudo chmod 777 /etc/environment
sudo echo "JAVA_HOME=\"/usr/lib/jvm/default-java\"" >> /etc/environment
sudo chmod 644 /etc/environment

echo "INSTALLING: netbeans (snap)"
sudo snap install netbeans --classic