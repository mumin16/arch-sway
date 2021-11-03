:'
eğer bağlantınız wifi ise

iwlist scanning
iwctl station wlan0 connect wifi_adi

wifi_şifresi girersiniz istediğinde
'
DISK=sda
PASS=1

wipefs -a /dev/"$DISK"
(echo n; echo p; echo -ne '\n'; echo -ne '\n'; echo -ne '\n'; echo +512m; echo n; echo p; echo -ne '\n'; echo -ne '\n'; echo -ne '\n'; echo w;) | fdisk /dev/"$DISK"

mkfs.fat -F32 /dev/"$DISK"1     
mkfs.ext4 /dev/"$DISK"2

:'
mount /dev/"$DISK"2 /mnt
pacstrap /mnt base linux linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
timedatectl set-timezone "Europe/Istanbul"
timedatectl set-ntp true
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=tr" > /etc/vconsole.conf
echo "linux" > /etc/hostname
mkinitcpio -P
passwd
echo "$PASS"
echo "$PASS"

useradd -m x64 -p "$PASS"
usermod -aG wheel x64
pacman -S --needed --noconfirm sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

pacman -S --needed --noconfirm grub 
grub-install --target=i386-pc /dev/"$DISK"
grub-mkconfig -o /boot/grub/grub.cfg


pacman -S --needed --noconfirm networkmanager
systmectl enable NetworkManager

umount -R /mnt
exit
reboot
'






