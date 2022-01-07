sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ..
rm -rf yay-bin
yay -S --needed --noconfirm nano htop neofetch mpv featherpad
yay -S --needed --noconfirm sway-git foot-git rofi swayidle ttf-font-awesome
yay -S --needed --noconfirm qt5-wayland pcmanfm-qt qt5ct lxqt-policykit lxqt-archiver rar zip unzip
yay -S --needed --noconfirm gvfs ntfs-3g 
yay -S --needed --noconfirm acpi brightnessctl grim
yay -S --needed --noconfirm pulseaudio pulseaudio-alsa alsa-utils
mkdir ~/.config/sway
mkdir ~/.config/foot
mkdir ~/.config/qt5ct
mkdir ~/.config/pcmanfm-qt
mkdir ~/.config/pcmanfm-qt/default
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/foot.ini --output ~/.config/foot/foot.ini
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/config --output ~/.config/sway/config
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/swaybar.sh --output ~/.config/sway/swaybar.sh
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/click_time.sh --output ~/.config/sway/click_time.sh
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/shortcuts.sh --output ~/.config/sway/shortcuts.sh
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/qt5ct.conf --output ~/.config/qt5ct/qt5ct.conf
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/settings.conf --output ~/.config/pcmanfm-qt/default/settings.conf
echo "input type:keyboard xkb_layout" "$(localectl status | grep "X11 Layout" | sed -e "s/^.*X11 Layout://")" >> ~/.config/sway/config
sudo chmod 777 ~/.config/sway/shortcuts.sh
sudo chmod 777 ~/.config/sway/click_time.sh
sudo chmod 777 ~/.config/sway/swaybar.sh
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/sway.jpg --output ~/.config/sway/sway.jpg
curl https://raw.githubusercontent.com/mumin16/arch-sway/main/electron-flags.conf --output ~/.config/electron-flags.conf
yay -S --needed --noconfirm sddm
sudo systemctl enable sddm

cp /etc/profile .
echo "export MOZ_ENABLE_WAYLAND=1" >> profile
echo "export XDG_CURRENT_DESKTOP=sway" >> profile
echo "export XDG_SESSION_TYPE=wayland" >> profile
echo "export WLR_NO_HARDWARE_CURSORS=1" >> profile
echo "export WLR_RENDERER_ALLOW_SOFTWARE=1" >> profile
echo "export _JAVA_AWT_WM_NONREPARENTING=1" >> profile
echo "export QT_QPA_PLATFORMTHEME="qt5ct"" >> profile
#echo "export QT_QPA_PLATFORM=wayland" >> profile
sudo cp profile /etc/
rm -rf profile

yay -S --needed --noconfirm chromium
#yay -S --needed --noconfirm onlyoffice
#yay -S --needed --noconfirm obs-studio  
#yay -S --needed --noconfirm visual-studio-code-bin gdb ninja cmake npm
#yay -S --needed --noconfirm ufw nginx certbot-nginx
: '
sudo pacman -S virtualbox
sudo modprobe vboxdrv
sudo usermod -aG vboxusers "$USER"
sudo pacman -S --needed --noconfirm virtualbox-guest-iso
'
rm -rf install.sh
yay -Sc --noconfirm
echo "reboot please"
#reboot
