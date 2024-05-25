#!/bin/bash

# Start with updates.
sudo apt update
sudo apt-get upgrade -y

# Install programs / utils
sudo apt-get install -y tilix
sudo apt-get install -y git
# sudo apt-get install -y docker
sudo apt-get install -y vim
# sudo apt-get install -y curl
# sudo apt-get install -y tmux

# Github login
read -p "Enter your email: " email
read -sp "Enter your token: " token
git config --global user.email "$email"
git config --global user.token "$token"

# Generate GPG key
gpg --full-generate-key

# Get GPG key ID
key_id=$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | awk -F '/' '{print $2}')

# Configure Git to use GPG key for signing commits
git config --global user.signingkey $key_id
git config --global commit.gpgsign true

echo "Git configured successfully."
