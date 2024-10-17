#! /bin/bash
#
# Volume Levels:
# - 1st for mute
# - Every other symbol would work for unmute (get audio level)
# - 1 icon every 20%
# - Last one for >100%
#
# 󰝟 󰕿 󰝞 󰖀 󰝝 󰕾 󱄡
# 󰍭 󰍯 󰢳 󰍮 󰢴 󱦉 󰍰
#
# 󰝟 󰕿 󰝞 󰖀 󰝝 󰕾 󱄡
# 󰍭 󰍯 󰢳 󰍮 󰢴 󱦉 󰍰  

notification() {
	hyprctl notify $1 1500 "rgb(1f494b)" "fontsize:28   $2"
  # 0 - Alert
  # 1 - Hint
  # 2 - Idea
  # 3 - Error
  # 4 - Question
  # 5 - Tick
}

# Get Volume
get_volume() {
	VOLUME=$(pamixer --get-volume)
	echo "$VOLUME"
}

# Increase Volume
inc_volume() {
	pamixer -i 5 || return 

  LEVEL=$(get_volume)
  if [ ${LEVEL} -le 0 ]; then
    notification 4 "  󰝟  Volume:${LEVEL}"
  elif [ ${LEVEL} -lt 30 ]; then
    notification 4 "  󰋍  Volume:${LEVEL}"
  elif [ ${LEVEL} -ge 150 ]; then
    notification 3 "  󱄡  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 100 ]; then
    notification 3 "  󰜟  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 70 ]; then
    notification 0 "  󰟎  Volume:${LEVEL}"
  else
    notification 5 "  󰋋  Volume:${LEVEL}"
  fi
}

# Decrease Volume
dec_volume() {
	pamixer -d 5 || return

  LEVEL=$(get_volume)
  if [ ${LEVEL} -le 0 ]; then
    notification 4 "  󰝟  Volume:${LEVEL}"
  elif [ ${LEVEL} -lt 30 ]; then
    notification 4 "  󰋍  Volume:${LEVEL}"
  elif [ ${LEVEL} -ge 150 ]; then
    notification 3 "  󱄡  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 100 ]; then
    notification 3 "  󰜟  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 70 ]; then
    notification 0 "  󰟎  Volume:${LEVEL}"
  else
    notification 5 "  󰋋  Volume:${LEVEL}"
  fi
}

# Toggle Mute
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "false" ]; then
    pamixer -m || return

    notification 4 "  󰝟  Volume:Mute"
	elif [ "$(pamixer --get-mute)" == "true" ]; then
    pamixer -u || return

    LEVEL=$(get_volume)
    if [ ${LEVEL} -le 0 ]; then
      notification 4 "  󰝟  Volume:${LEVEL}"
    elif [ ${LEVEL} -lt 30 ]; then
      notification 4 "  󰋍  Volume:${LEVEL}"
    elif [ ${LEVEL} -ge 150 ]; then
      notification 3 "  󱄡  Volume:${LEVEL}"
    elif [ ${LEVEL} -gt 100 ]; then
      notification 3 "  󰜟  Volume:${LEVEL}"
    elif [ ${LEVEL} -gt 70 ]; then
      notification 0 "  󰟎  Volume:${LEVEL}"
    else
      notification 5 "  󰋋  Volume:${LEVEL}"
    fi
	fi
}

# Get MIC Volume
get_mic_volume() {
	MIC_VOLUME=$(pamixer --default-source --get-volume)
	echo "$MIC_VOLUME"
}

# Increase MIC Volume
inc_mic_volume() {
	pamixer --default-source -i 5 || return

  LEVEL=$(get_mic_volume)
  if [ ${LEVEL} -le 0 ]; then
    notification 4 "  󰍭  Mic:${LEVEL}"
  elif [ ${LEVEL} -lt 30 ]; then
    notification 4 "  󰢳  Mic:${LEVEL}"
  elif [ ${LEVEL} -ge 150 ]; then
    notification 3 "  󱄡  Mic:${LEVEL}"
  elif [ ${LEVEL} -gt 100 ]; then
    notification 3 "  󰍰  Mic:${LEVEL}"
  elif [ ${LEVEL} -gt 70 ]; then
    notification 0 "  󰢴  Mic:${LEVEL}"
  else
    notification 5 "  󰍬  Mic:${LEVEL}"
  fi
}

# Decrease MIC Volume
dec_mic_volume() {
	pamixer --default-source -d 5 || return

  LEVEL=$(get_mic_volume)
  if [ ${LEVEL} -le 0 ]; then
    notification 4 "  󰍭  Mic:${LEVEL}"
  elif [ ${LEVEL} -lt 30 ]; then
    notification 4 "  󰢳  Mic:${LEVEL}"
  elif [ ${LEVEL} -ge 150 ]; then
    notification 3 "  󱄡  Mic:${LEVEL}"
  elif [ ${LEVEL} -gt 100 ]; then
    notification 3 "  󰍰  Mic:${LEVEL}"
  elif [ ${LEVEL} -gt 70 ]; then
    notification 0 "  󰢴  Mic:${LEVEL}"
  else
    notification 5 "  󰍬  Mic:${LEVEL}"
  fi
}

# Toggle Mic
toggle_mic_mute() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m

    notification 4 "  󰍭  Mic-Mute"
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer -u --default-source u

    LEVEL=$(get_mic_volume)
    if [ ${LEVEL} -le 0 ]; then
      notification 4 "  󰍭  Mic:${LEVEL}"
    elif [ ${LEVEL} -lt 30 ]; then
      notification 4 "  󰢳  Mic:${LEVEL}"
    elif [ ${LEVEL} -ge 150 ]; then
      notification 3 "  󱄡  Mic:${LEVEL}"
    elif [ ${LEVEL} -gt 100 ]; then
      notification 3 "  󰍰  Mic:${LEVEL}"
    elif [ ${LEVEL} -gt 70 ]; then
      notification 0 "  󰢴  Mic:${LEVEL}"
    else
      notification 5 "  󰍬  Mic:${LEVEL}"
    fi
	fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--mic-get" ]]; then
  get_mic_volume
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
elif [[ "$1" == "--mic-toggle" ]]; then
	toggle_mic_mute
else
	get_volume
fi
