:'
Eğer bağlantınız wifi ise
iwlist scanning
iwctl station wlan0 connect wifi_adi
'
DISK=sda
PASS=1

wipefs -a /dev/"$DISK"
(echo n; echo -ne '\n'; echo -ne '\n'; echo -ne '\n'; echo +512m; echo y; echo n; echo -ne '\n'; echo -ne '\n'; echo -ne '\n'; echo w;) | fdisk /dev/"$DISK"

mkfs.fat -F32 /dev/"$DISK"1     
#♣mkfs.ext4 /dev/"$DISK"2
