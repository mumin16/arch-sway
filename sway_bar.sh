# Keyboard layout name
keyboard_layout_name="$(localectl status | grep "X11 Layout" | sed -e "s/^.*X11 Layout://")"

# Date and time
current_time=$(date "+%H:%M")

# Audio
audio_volume=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))

# Network
network=$(nmcli -t -f NAME c show --active)

# Battery
battery_info=$(acpi -b | sed -r 's/.*([0-9]{2,3}%).*/\1/')

echo "🌐$network | 🔋$battery_info | ⌨️$keyboard_layout_name | 🔊$audio_volume | 🕘$current_time"
