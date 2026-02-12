#!/bin/bash

echo "Automate Script for making ready a new ubuntu server"
# ===============
# update server
# ===============
sudo apt update
sudo apt upgrade -y
sleep 2
echo "-------- Systemct APT updated"

# ===============
# Set new Password
# ===============
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sudo systemctl restart ssh && sudo passwd
echo "-------- Password Changed"

# ===============
# change ssh Port
# ===============
sudo sed -i 's/#Port 22/Port 8443/' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo systemctl restart ssh

echo "-------- SSH PORT Changed"

# ===============
# ufw enabling
# ===============
sudo ufw allow 8443/tcp
sudo ufw allow 443/tcp
sudo ufw allow 80/tcp
sudo ufw enable

echo "-------- UFW enabled and ports allowed"


# ===============
# install zsh & oh my zsh
# ===============
cd ~
sudo apt install -y zsh curl git
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo "-------- zsh & oh my zsh installed"

echo "-------- for adding ohMyZSH autosuggestions run this:
      git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
      sudo sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc "
