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
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/.gtkrc-2.0 --output ~/.gtkrc-2.0
yay -S --needed --noconfirm pulseaudio pulseaudio-alsa alsa-utils
yay -S --needed --noconfirm chromium
mkdir ~/.config/sway
mkdir ~/.config/foot
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/foot.ini --output ~/.config/foot/foot.ini
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/config --output ~/.config/sway/config
echo "input type:keyboard xkb_layout" "$(localectl status | grep "X11 Layout" | sed -e "s/^.*X11 Layout://")" >> ~/.config/sway/config
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/sway.png --output ~/.config/sway/sway.png
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/.bash_profile --output ~/.bash_profile
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/electron-flags.conf --output ~/.config/electron-flags.conf
sudo curl https://raw.githubusercontent.com/mumin16/arch-sway/main/10-udisks2.rules --output /etc/polkit-1/rules.d/10-udisks2.rules
sudo usermod -a -G storage "$USER" 
yay -S --needed --noconfirm networkmanager
sudo systemctl disable systemd-networkd
sudo systemctl disable systemd-resolved
sudo systemctl disable iwd
sudo systemctl enable NetworkManager
rm -rf install.sh
yay -Sc --noconfirm
reboot
