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
cd scripts
sudo sh qtile-commands
cd ..

# Packages needed for window manager installation
sudo nala install -y picom rofi dunst libnotify-bin unzip thunar thunar-archive-plugin thunar-volman file-roller alacritty

# XFCE4 Minimal
# sudo nala install -y xfce4 xfce4-goodies

# Network /System Events/Sound Packages/Appearance management/ Lightdm Console Display Manager
sudo nala install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends xfce4-power-manager policykit-1-gnome network-manager network-manager-gnome pulseaudio alsa-utils pavucontrol volumeicon-alsa pamixer network-manager network-manager-gnome lxappearance feh lightdm lightdm-gtk-greeter-settings

sudo systemctl enable avahi-daemon
sudo systemctl enable acpid
sudo systemctl enable lightdm

# copy my configuration files into the ~/.config directory
sudo mkdir -p /home/$username/.config
sudo cp -r dotconfig/* /home/$username/.config/

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"