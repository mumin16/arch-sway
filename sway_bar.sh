# Change this according to your device
################
# Variables
################

# Keyboard input name
keyboard_input_name="$(localectl status | grep "X11 Layout" | sed -e "s/^.*X11 Layout://")"

# Date and time
current_time=$(date "+%H:%M")

#############
# Commands
#############

# Battery or charger
#battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
#battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio
audio_volume=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))

# Network
#network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
## interface_easyname grabs the "old" interface name before systemd renamed it
#interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
#ping=$(ping -c 1 www.google.es | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

# Others
#language=$(swaymsg -r -t get_inputs | awk '/1:1:AT_Translated_Set_2_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b1:1:AT_Translated_Set_2_keyboard\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')
#loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

# Removed weather because we are requesting it too many times to have a proper
# refresh on the bar
#weather=$(curl -Ss 'https://wttr.in/Pontevedra?0&T&Q&format=1')

#if [ $battery_status = "discharging" ];
#then
#    battery_pluggedin='⚠'
#else
#    battery_pluggedin='⚡'
#fi

#if ! [ $network ]
#then
#   network_active="⛔"
#else
#   network_active="⇆"
#fi

#if [ $player_status = "Playing" ]
#then
#    song_status='▶'
#elif [ $player_status = "Paused" ]
#then
#    song_status='⏸'
#else
#    song_status='⏹' 
#fi

#echo "🎧 $song_status $media_artist - $media_song | ⌨ $language | $network_active $interface_easyname ($ping ms) | 🏋 $loadavg_5min | $audio_active $audio_volume% | $battery_pluggedin $battery_charge | $date_and_week 🕘 $current_time"
echo "⌨️$keyboard_input_name | 🔊$audio_volume | 🕘$current_time"
