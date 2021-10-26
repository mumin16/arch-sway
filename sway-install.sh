#!/bin/bash

# Easy setup for testing

sudo pacman -S --needed --noconfirm git
git clone https://aur.archlinux.org/yay-bin.git
cd ~/yay-bin
makepkg -si
cd ..
sudo rm -rf yay-bin
yay -S --needed --noconfirm nordic-darker-theme
yay -S --needed --noconfirm arc-x-icons-theme
cp -R .config/* ~/.config/
cp .profile ~/.profile
cp .gtkrc-2.0 ~/.gtkrc-2.0
chmod -R +x ~/.config/sway/scripts
chmod -R +x ~/.config/waybar/scripts
sudo pacman -Syu --needed --noconfirm - < packages-repository.txt
dbus-launch dconf load / < xed.dconf
