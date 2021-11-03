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

echo -e "y\n" | mount /dev/"$DISK"2 /mnt

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

echo -e "timedatectl set-timezone "Europe/Istanbul"" | arch-chroot /mnt
echo -e "timedatectl set-ntp true" | arch-chroot /mnt
echo -e "locale-gen" | arch-chroot /mnt
echo -e "echo "LANG=en_US.UTF-8" > /etc/locale.conf" | arch-chroot /mnt
echo -e "echo "KEYMAP=tr" > /etc/vconsole.conf" | arch-chroot /mnt
echo -e "echo "$HOST" > /etc/hostname" | arch-chroot /mnt
echo -e "mkinitcpio -P" | arch-chroot /mnt
echo -e "echo -e "$PASS\n$PASS\n" | passwd" | arch-chroot /mnt

echo -e "useradd -m "$USER" -p "$PASS"" | arch-chroot /mnt
echo -e "usermod -aG wheel "$USER"" | arch-chroot /mnt
echo -e "pacman -S --needed --noconfirm sudo" | arch-chroot /mnt
echo -e "echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers" | arch-chroot /mnt

echo -e "pacman -S --needed --noconfirm grub " | arch-chroot /mnt
echo -e "grub-install --target=i386-pc /dev/"$DISK"" | arch-chroot /mnt
echo -e "grub-mkconfig -o /boot/grub/grub.cfg" | arch-chroot /mnt

echo -e "pacman -S --needed --noconfirm networkmanager" | arch-chroot /mnt
echo -e "systmectl enable NetworkManager" | arch-chroot /mnt

umount -R /mnt
exit
reboot
