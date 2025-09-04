#!/bin/bash

echo "🚀 Setting up Docker in GitHub Codespaces..."

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

echo "✅ Docker installed successfully!"
echo "🧪 Test with: docker compose up --build"