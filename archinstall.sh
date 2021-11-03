:'
Eger internet baglantiniz wifi ise
iwlist scanning
iwctl station wlan0 connect wifi_adi
'
DISK=sda
PASS=1

wipefs -a -f /dev/"$DISK"
echo -e "n\n\n\n\n+512m\ny\nn\n\n\n\n\nw\n" | fdisk /dev/"$DISK"

mkfs.vfat -F32 /dev/"$DISK"1     
mkfs.ext4 /dev/"$DISK"2
