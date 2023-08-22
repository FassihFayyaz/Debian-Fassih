#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# Fetch Latest/Fastest Mirrors
nala fetch --debian bookworm --https-only

# XFCE4 Minimal
# sudo nala install -y xfce4 xfce4-goodies

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp wallpaper.png /home/$username/Pictures/backgrounds/
chown -R $username:$username /home/$username

# Installing Essential Programs 
nala install feh alacritty rofi dunst copyq thunar nitrogen lxpolkit x11-xserver-utils unzip wget pulseaudio pavucontrol build-essential libx11-dev libxft-dev libxinerama-dev -y
# Installing Other less important Programs
nala install neofetch arandr xrandr flameshot psmisc lxappearance papirus-icon-theme lxappearance fonts-noto-color-emoji lightdm -y

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd $builddir
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
nala update

# Enable graphical login and change target from CLI to GUI
systemctl enable lightdm
systemctl set-default graphical.target

# Install Qtile
cd $builddir
sh scripts/qtile-install

#Install Qtile-Extras
cd $builddir


# Use Nala
cd $builddir
sh scripts/usenala

# copy my configuration files into the ~/.config directory
cd $builddir
sudo cp -r dotconfig/* /home/$username/.config/

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"