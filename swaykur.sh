sudo pacman -S --needed --noconfirm git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ..
rm -rf yay-bin
yay -S --needed --noconfirm nano htop neofetch
yay -S --needed --noconfirm sway-git foot-git dmenu
yay -S --needed --noconfirm nordic-darker-theme paper-icon-theme
yay -S --needed --noconfirm pcmanfm lxappearance gvfs ntfs-3g xarchiver rar zip unzip 
yay -S --needed --noconfirm pulseaudio pulseaudio-alsa alsa-utils
yay -S --needed --noconfirm chromium
yay -S --needed --noconfirm networkmanager
sudo systemctl disable systemd-networkd
sudo systemctl disable systemd-resolved
sudo systemctl disable iwd
sudo systemctl enable NetworkManager
mkdir ~/.config/sway
mkdir ~/.config/foot
cp -rf /etc/sway/* ~/.config/sway/
cp -rf /usr/share/foot/* ~/.config/foot/
yay -Sc --noconfirm
reboot
