:'
Eger internet baglantiniz wifi ise
iwlist scanning
iwctl station wlan0 connect wifi_adi
'
DISK=sda
PASS=1

wipefs -a -f /dev/"$DISK"
echo -e "n\n\n\n+512m\nn\n\n\n\nw" | fdisk /dev/"$DISK"

mkfs.vfat -F32 /dev/"$DISK"1     
mkfs.ext4 /dev/"$DISK"2
