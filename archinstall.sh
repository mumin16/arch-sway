:'
Eğer bağlantınız wifi ise
iwlist scanning
iwctl station wlan0 connect wifi_adi
'
DISK=sda
PASS=1

wipefs -a /dev/"$DISK"
(echo n; echo p; echo 1; echo 2048; echo +512m; echo y; echo n; echo p; echo 2; ... ; ... ; echo w;) | fdisk /dev/"$DISK"

mkfs.fat -F32 /dev/"$DISK"1     
mkfs.ext4 /dev/"$DISK"2
