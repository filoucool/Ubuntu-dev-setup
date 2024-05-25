#!/bin/bash
# Start with updates.
sudo apt update
sudo apt-get upgrade -y


# install chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable


# Install programs / utils
sudo apt-get install -y tilix
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y curl
sudo apt-get install -y tmux
sudo apt-get install -y neovim
sudo apt-get install -y texmaker
sudo apt-get install -y gtg
sudo apt-get install -y htop

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo docker run hello-world


# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
sudo usermod -aG docker ${USER}
su - ${USER}
docker run hello-world


# Github login
read -p "Enter your email: " email
read -sp "Enter your token: " token
git config --global user.email "$email"
git config --global user.token "$token"
git config --global credential.helper store


# install nvchad 
git clone https://github.com/NvChad/NvChad ~/.config/nvim
# Change directory to nvchad
cd ~/.config/nvim
echo "nvchad installed successfully."


# Generate GPG key
gpg --full-generate-key
# Get GPG key ID
key_id=$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | awk -F '/' '{print $2}')
# Configure Git to use GPG key for signing commits
git config --global user.signingkey $key_id
git config --global commit.gpgsign true
echo "Git configured successfully."
# Return Full GPG key
echo "Add this new GPG key to your github Account:"
echo ""
key=$(gpg --armor --export $key_id)
echo "$key"
