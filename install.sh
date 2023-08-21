#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# Update packages list and update system
sudo apt update
sudo apt upgrade -y

# Install nala
apt install nala -y

# Fetch Latest Mirrors
sudo nala fetch

# display server installation and build-essentails installation

sudo nala install -y xorg xbacklight xbindkeys xvkbd xinput build-essential

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

# Install Qtile Window Manager
bash /home/$username/debian-config/scripts/qtile-commands

# My Favs

sudo nala install thunar, alacritty, picom, firefox-esr, rofi lightdm lightdm-gtk-greeter-settings -y

# XFCE4 Minimal
# sudo apt install -y xfce4 xfce4-goodies

# copy my configuration files into the ~/.config directory
cp dotconfig/* /home/$username/.config/

sudo systemctl enable lightdm