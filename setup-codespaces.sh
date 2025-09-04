#!/bin/bash

echo "🚀 Setting up Sysbox in GitHub Codespaces..."

# Update package list
sudo apt update

# Install prerequisites
sudo apt install -y curl wget

# Install Docker (if not already installed)
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
fi

# Install Sysbox
echo "Installing Sysbox..."
curl -fsSL https://downloads.nestybox.com/sysbox/releases/0.7.2/sysbox-ce_0.7.2-0.linux_amd64.deb -o sysbox.deb
sudo dpkg -i sysbox.deb
sudo apt-get install -f

# Start Sysbox service
sudo systemctl start sysbox
sudo systemctl enable sysbox

# Restart Docker daemon
sudo systemctl restart docker

echo "✅ Sysbox installed successfully!"
echo "🔄 Please restart your Codespace or run: sudo systemctl restart docker"
echo "🧪 Test with: docker compose up --build"
