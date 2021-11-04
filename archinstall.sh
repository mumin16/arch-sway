:'
Eger internet baglantiniz wifi ise
iwlist scanning
iwctl station wlan0 connect wifi_adi
'
DISK=sda
HOST=linux
USER=arch
PASS=1

wipefs -a -f /dev/"$DISK"
echo -e "n\n\n\n\n+512m\ny\nn\n\n\n\n\nw\n" | fdisk /dev/"$DISK"

mkfs.vfat -F32 /dev/"$DISK"1     
mkfs.ext4 /dev/"$DISK"2

mount /dev/"$DISK"2 /mnt
pacstrap /mnt base linux linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
timedatectl set-timezone "Europe/Istanbul"
timedatectl set-ntp true
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=trq" > /etc/vconsole.conf
echo ""$HOST"" > /etc/hostname
mkinitcpio -P
passwd
echo ""$PASS"\n"
echo ""$PASS"\n" 

useradd -m "$USER" -p "$PASS"
usermod -aG wheel "$USER"
pacman -S --needed --noconfirm sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

pacman -S --needed --noconfirm grub 
grub-install --target=i386-pc /dev/"$DISK"
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --needed --noconfirm networkmanager
systemctl enable NetworkManager

umount -R /mnt
#exit
#reboot
