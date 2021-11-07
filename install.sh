sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ..
rm -rf yay-bin
yay -S --needed --noconfirm nano htop neofetch
yay -S --needed --noconfirm sway-git foot-git fuzzel swayidle noto-fonts-emoji
yay -S --needed --noconfirm yambar ttf-font-awesome
yay -S --needed --noconfirm pcmanfm lxappearance xarchiver rar zip unzip material-black-colors-theme
yay -S --needed --noconfirm gvfs ntfs-3g 
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/.gtkrc-2.0 --output ~/.gtkrc-2.0
#sudo curl https://raw.githubusercontent.com/mumin16/arch-sway/main/10-udisks2.rules --output /etc/polkit-1/rules.d/10-udisks2.rules
#sudo usermod -a -G storage "$USER" 
yay -S --needed --noconfirm acpi brightnessctl grim
yay -S --needed --noconfirm pulseaudio pulseaudio-alsa alsa-utils
mkdir ~/.config/sway
mkdir ~/.config/foot
mkdir ~/.config/yambar
cp /etc/profile .
echo "export MOZ_ENABLE_WAYLAND=1" >> profile
echo "export XDG_CURRENT_DESKTOP=sway" >> profile
echo "export XDG_SESSION_TYPE=wayland" >> profile
echo "export WLR_NO_HARDWARE_CURSORS=1" >> profile
echo "export WLR_RENDERER_ALLOW_SOFTWARE=1" >> profile
echo "export _JAVA_AWT_WM_NONREPARENTING=1" >> profile
sudo cp profile /etc/
rm -rf profile
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/foot.ini --output ~/.config/foot/foot.ini
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/config --output ~/.config/sway/config
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/sway_bar.sh --output ~/.config/sway/sway_bar.sh
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/config.yml --output ~/.config/yambar/config.yml
echo "input type:keyboard xkb_layout" "$(localectl status | grep "X11 Layout" | sed -e "s/^.*X11 Layout://")" >> ~/.config/sway/config
#curl https://raw.githubusercontent.com/mumin16/arch-sway/main/sway.png --output ~/.config/sway/sway.png
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/.bash_profile --output ~/.bash_profile
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/electron-flags.conf --output ~/.config/electron-flags.conf
yay -S --needed --noconfirm networkmanager
sudo systemctl disable systemd-networkd
sudo systemctl disable systemd-resolved
sudo systemctl disable iwd
sudo systemctl enable NetworkManager
yay -S --needed --noconfirm chromium
#yay -S --needed --noconfirm obs-studio qt5-wayland mpv
#yay -S --needed --noconfirm visual-studio-code-bin gdb ninja cmake npm
#yay -S --needed --noconfirm ufw nginx certbot-nginx
: '
sudo pacman -S --needed --noconfirm virtualbox
sudo modprobe vboxdrv
sudo usermod -aG vboxusers "$USER"
sudo pacman -S --needed --noconfirm virtualbox-guest-iso
'
rm -rf install.sh
yay -Sc --noconfirm
reboot
