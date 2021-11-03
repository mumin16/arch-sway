:'
#eğer bağlantınız wifi ise
iwlist scanning
iwctl station wlan0 connect wifi_adi
#wifi_şifresi girersiniz istediğinde
'
DISK=sda
# türkçe q klavye
#loadkeys trq
# sistem saatini güncelle
#timedatectl set-ntp true
# diskli biçimle
#fdisk -l
#fdisk /dev/"$DISK"
#d  #tüm bölümleri sil
#n  #+512m ve kalan şekilde boot ve root 2 bölüm yarat
#w
mkfs.fat -F32 /dev/"$DISK"1     
mkfs.ext4 /dev/"$DISK"2

#root u mount et ve temel sistem yüklemelerini yap
mount /dev/"$DISK"2 /mnt
pacstrap /mnt base linux linux-firmware

#sistem ayarlamaları
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
timedatectl set-timezone "Europe/Istanbul"
timedatectl set-ntp true
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=tr" > /etc/vconsole.conf
echo "linux" > /etc/hostname
mkinitcpio -P
passwd 1 #root şifre
# kullanici ekle
useradd -m x64 -p 1
usermod -aG wheel x64
pacman -S --needed --noconfirm sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
#boot yükleyici
pacman -S --needed --noconfirm grub 
grub-install --target=i386-pc /dev/"$DISK"
grub-mkconfig -o /boot/grub/grub.cfg

#network
pacman -S --needed --noconfirm networkmanager
systmectl enable NetworkManager

umount -R /mnt
exit
reboot







