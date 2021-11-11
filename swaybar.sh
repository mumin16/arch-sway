#!/bin/sh

# sway config in ~/.config/sway/config :
# bar {
#   status_command exec ~/.config/sway/swaybar.sh
# }

bg_bar_color="#282A36"

# Print a left caret separator
# @params {string} $1 text color, ex: "#FF0000"
# @params {string} $2 background color, ex: "#FF0000"
separator() {
  echo -n "{"
  echo -n "\"full_text\":\"\"," # CTRL+Ue0b2
  echo -n "\"separator\":false,"
  echo -n "\"separator_block_width\":0,"
  echo -n "\"border\":\"$bg_bar_color\","
  echo -n "\"border_left\":0,"
  echo -n "\"border_right\":0,"
  echo -n "\"border_top\":2,"
  echo -n "\"border_bottom\":2,"
  echo -n "\"color\":\"$1\","
  echo -n "\"background\":\"$2\""
  echo -n "}"
}

common() {
  echo -n "\"border\": \"$bg_bar_color\","
  echo -n "\"separator\":false,"
  echo -n "\"separator_block_width\":0,"
  echo -n "\"border_top\":2,"
  echo -n "\"border_bottom\":2,"
  echo -n "\"border_left\":0,"
  echo -n "\"border_right\":0"
}


conn() {
  local bg="#2E7D32" # vert
  separator $bg $bg_bar_color
  echo -n ",{"
  echo -n "\"name\":\"id_conn\","
  echo -n "\"full_text\":\"  $(nmcli -t -f NAME c show --active) \","
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
}


cpu_usage() {
  local bg="#3949AB"
  separator $bg "#2E7D32"  
  echo -n ",{"
  echo -n "\"name\":\"id_cpu_usage\","
  echo -n "\"full_text\":\"  $(awk '/^Mem/ {print $3}' <(free -m))M \","
  echo -n "\"background\":\"#3949AB\","
  common
  echo -n "},"
}

mydate() {
  local bg="#E0E0E0"
  separator $bg "#3949AB"
  echo -n ",{"
  echo -n "\"name\":\"id_time\","
  echo -n "\"full_text\":\"  $(date "+%H:%M") \","
  echo -n "\"color\":\"#000000\","
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
}

battery0() {
  if [ -f /sys/class/power_supply/BAT0/uevent ]; then
    local bg="#D69E2E"
    separator $bg "#E0E0E0"
    bg_separator_previous=$bg
    prct=$(cat /sys/class/power_supply/BAT0/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d'=' -f2)
    charging=$(cat /sys/class/power_supply/BAT0/uevent | grep "POWER_SUPPLY_STATUS" | cut -d'=' -f2) # POWER_SUPPLY_STATUS=Discharging|Charging
    icon=""
    if [ "$charging" == "Charging" ]; then
      icon=""
    fi
    echo -n ",{"
    echo -n "\"name\":\"battery0\","
    echo -n "\"full_text\":\" ${icon} ${prct}% \","
    echo -n "\"color\":\"#000000\","
    echo -n "\"background\":\"$bg\","
    common
    echo -n "},"
  else
    bg_separator_previous="#E0E0E0"
  fi
}

volume() {
  local bg="#673AB7"
  separator $bg $bg_separator_previous  
  vol=$(pamixer --get-volume)
  echo -n ",{"
  echo -n "\"name\":\"id_volume\","
  if [ $vol -le 0 ]; then
    echo -n "\"full_text\":\"  ${vol}% \","
  else
    echo -n "\"full_text\":\"  ${vol}% \","
  fi
  echo -n "\"background\":\"$bg\","
  common
  echo -n "},"
  separator $bg_bar_color $bg
}

logout() {
  echo -n ",{"
  echo -n "\"name\":\"id_logout\","
  echo -n "\"full_text\":\"  \""
  echo -n "}"
}

# https://github.com/i3/i3/blob/next/contrib/trivial-bar-script.sh
echo '{ "version": 1, "click_events":true }'     # Send the header so that i3bar knows we want to use JSON:
echo '['                    # Begin the endless array.
echo '[]'                   # We send an empty first array of blocks to make the loop simpler:

# Now send blocks with information forever:
(while :;
do
	echo -n ",["
  conn
  cpu_usage
  mydate
  battery0
  volume
  logout
  echo "]"
	sleep 10
done) &

# click events
while read line;
do
  # CHECK CONNECTION
  if [[ $line == *"name"*"id_conn"* ]]; then
    foot -e nmtui &

  # CPU
  elif [[ $line == *"name"*"id_cpu_usage"* ]]; then
    foot -e htop &

  # TIME
  elif [[ $line == *"name"*"id_time"* ]]; then
    foot -e ~/.config/sway/click_time.sh &

  # VOLUME
  elif [[ $line == *"name"*"id_volume"* ]]; then
    foot -e alsamixer &

  # LOGOUT
  elif [[ $line == *"name"*"id_logout"* ]]; then
    swaynag -t warning -m 'Power off?' -b 'yes' 'foot poweroff' > /dev/null &

  fi  
done