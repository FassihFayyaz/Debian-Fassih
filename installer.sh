#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# Update packages list and update system
sudo apt update
sudo apt upgrade -y

# Install nala
apt install nala -y

# Fetch Latest/Fastest Mirrors
sudo nala fetch --debian bookworm --https-only

# XFCE4 Minimal
# sudo nala install -y xfce4 xfce4-goodies

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

# Making .config and Moving config files and background to Pictures
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp wallpaper.png /home/$username/Pictures/backgrounds/
chown -R $username:$username /home/$username

# Installing Essential Programs 
nala install feh alacritty rofi thunar nitrogen lxpolkit x11-xserver-utils unzip wget pulseaudio xorg pavucontrol build-essential libx11-dev libxft-dev libxinerama-dev -y
# Installing Other less important Programs
nala install neofetch arandr flameshot psmisc mangohud lxappearance papirus-icon-theme lxappearance fonts-noto-color-emoji lightdm -y

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
rm -rf Nordzy-cursors

# Enable graphical login and change target from CLI to GUI
systemctl enable lightdm
systemctl set-default graphical.target

# Install Qtile
sh scripts/qtile-commands

# copy my configuration files into the ~/.config directory
sudo cp -r dotconfig/* /home/$username/.config/

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"