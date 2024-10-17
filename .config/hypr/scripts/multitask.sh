#! /bin/bash

notification() {
	hyprctl notify $1 1500 "rgb(1f494b)" "fontsize:28   $2"
  # 0 - Alert
  # 1 - Hint
  # 2 - Idea
  # 3 - Error
  # 4 - Question
  # 5 - Tick
}

STATUS=$(readlink -f /home/iCode/.config/hypr/run-time/multitask | cut -d '/' -f 7-7)

multitask_off() {
	cd /home/iCode/.config/hypr/run-time/;
	unlink multitask
	ln -s multitask_off multitask
	cd - >> /dev/null
#	tmux set status on
# alacritty msg config font.size=15
}

multitask_on() {
	cd /home/iCode/.config/hypr/run-time/;
	unlink multitask
	ln -s multitask_on multitask
	cd - >> /dev/null
#	tmux set status off
# alacritty msg config font.size=20
}

cmd_start() {
	multitask_on
	# notify-send -u low "    Start"
	notification 5 "󰿎       Start"
}

cmd_restart() {
	echo '{ "command": ["seek", "0", "absolute"] }' | socat - /tmp/mpvsocket
	# notify-send "   Restart"
	notification 5 "󰿎 󰑙    Restart"
}

cmd_stop() {
	echo '{ "command": ["quit"] }' | socat - /tmp/mpvsocket
	multitask_off
	# notify-send -u low "󰘪    Stop"
	notification 3 "󰿎        Stop"
}

cmd_pause() {
	echo '{ "command": ["cycle", "pause"] }' | socat - /tmp/mpvsocket
	[ $STATUS == "multitask_off" ] && multitask_on || multitask_off
	# [ $STATUS == "multitask_off" ] && notify-send -u low "󰴄    Resume" || notify-send -u low "    Pause"
	[ $STATUS == "multitask_off" ] && notification 0 "󰿎 󰴄     Resume" || notification 0 "󰿎       Pause"
}

cmd_toggle() {
	echo '{ "command": ["set_property", "pause", "no"] }' | socat - /tmp/mpvsocket
	[ $STATUS == "multitask_off" ] && multitask_on || multitask_off
	# [ $STATUS == "multitask_off" ] && notify-send -u low "󰴄    Toggle" || notify-send -u low "    Toggle"
	[ $STATUS == "multitask_off" ] && notification 0 "󰿎 󰴄    Visible" || notification 0 "󰿎      Hidden"
}

cmd_forward() {
	[ $1 -eq 10 ] && echo '{ "command": ["seek", "+10"] }' | socat - /tmp/mpvsocket || echo '{ "command": ["seek", "+60"] }' | socat - /tmp/mpvsocket
	# [ $1 -eq 10 ] && notify-send -u low "   Forward 󰵱 " || notify-send -u low "󰓘   Forward 󱘋 "
	[ $1 -eq 10 ] && notification 1 "󰿎  Forward 󰵱 " || notification 1 "󰿎 󰓘 Forward 󱘋 "
}

cmd_rewind() {
	[ $1 -eq 10 ] && echo '{ "command": ["seek", "-10"] }' | socat - /tmp/mpvsocket || echo '{ "command": ["seek", "-60"] }' | socat - /tmp/mpvsocket
	# [ $1 -eq 10 ] && notify-send -u low "   Rewind 󰴪 " || notify-send -u low "󰓖   Rewind 󱘌 "
	[ $1 -eq 10 ] && notification 1 "󰿎   Rewind 󰴪 " || notification 1 "󰿎 󰓖  Rewind 󱘌 "
}

cmd_next() {
  echo '{ "command": ["playlist-next", "force"] }' | socat - /tmp/mpvsocket
	# notify-send -u low "   Next"
	notification 2 "󰿎        Next"
}

cmd_previous() {
  echo '{ "command": ["playlist-prev", "force"] }' | socat - /tmp/mpvsocket
	# notify-send -u low "   Previous"
	notification 2 "󰿎    Previous"
}

cmd_incvolume() {
	[ $1 -eq 10 ] && echo '{ "command": ["add", "volume", "10"] }' | socat - /tmp/mpvsocket || echo '{ "command": ["set_property", "volume", "70"] }' | socat - /tmp/mpvsocket

  LEVEL=`echo '{ "command": ["get_property", "volume"] }' | socat - /tmp/mpvsocket | cut -d ':' -f 2-2 | cut -d '.' -f 1-1`

  [ -z ${LEVEL} ] && LEVEL=0
	# [ $1 -eq 10 ] && notify-send -u low "󰋋 󰶣   Volume:${LEVEL}" || notify-send -u low "󰋋 󰔓   Volume:$1"

  if [ ${LEVEL} -le 0 ]; then
    notification 4 "󰿎 󰝟  Volume:${LEVEL}"
  elif [ ${LEVEL} -lt 30 ]; then
    notification 4 "󰿎 󰋍  Volume:${LEVEL}"
  elif [ ${LEVEL} -ge 150 ]; then
    notification 3 "󰿎 󱄡  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 100 ]; then
    notification 3 "󰿎 󰜟  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 70 ]; then
    notification 0 "󰿎 󰟎  Volume:${LEVEL}"
  else
    notification 5 "󰿎 󰋋  Volume:${LEVEL}"
  fi
}

cmd_decvolume() {
	[ $1 -eq 10 ] && echo '{ "command": ["add", "volume", "-10"] }' | socat - /tmp/mpvsocket || echo '{ "command": ["set_property", "volume", "30"] }' | socat - /tmp/mpvsocket

  LEVEL=`echo '{ "command": ["get_property", "volume"] }' | socat - /tmp/mpvsocket | cut -d ':' -f 2-2 | cut -d '.' -f 1-1`

  [ -z ${LEVEL} ] && LEVEL=0
	# [ $1 -eq 10 ] && notify-send -u low "󰋋 󰶡   Volume:${LEVEL}" || notify-send -u low "󰋋 󰔑   Volume:$1"

  if [ ${LEVEL} -le 0 ]; then
    notification 4 "󰿎 󰝟  Volume:${LEVEL}"
  elif [ ${LEVEL} -lt 30 ]; then
    notification 4 "󰿎 󰋍  Volume:${LEVEL}"
  elif [ ${LEVEL} -ge 150 ]; then
    notification 3 "󰿎 󱄡  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 100 ]; then
    notification 3 "󰿎 󰜟  Volume:${LEVEL}"
  elif [ ${LEVEL} -gt 70 ]; then
    notification 0 "󰿎 󰟎  Volume:${LEVEL}"
  else
    notification 5 "󰿎 󰋋  Volume:${LEVEL}"
  fi
}

cmd_subtitle() {
  [ $1 -eq 1 ] && echo '{ "command": ["set_property", "sub-visibility", "yes"] }' | socat - /tmp/mpvsocket || echo '{ "command": ["set_property", "sub-visibility", "no"] }' | socat - /tmp/mpvsocket
	# [ $1 -eq 1 ] && notify-send -u low "󰨖   Subtitle: ON" || notify-send -u low "󰨖   Subtitle: OFF"
	[ $1 -eq 1 ] && notification 5 "󰿎 󰨖   Subtitle" || notification 3 "󰿎 󰨖   Subtitle"
}

[ -z $1 ] && exit

[ $1 == "start" ] && cmd_start
[ $1 == "restart" ] && cmd_restart
[ $1 == "stop" ] && cmd_stop
[ $1 == "pause" ] && cmd_pause
[ $1 == "toggle" ] && cmd_toggle

[ $1 == "step-forward" ] && cmd_forward 10
[ $1 == "fast-forward" ] && cmd_forward 60
[ $1 == "step-rewind" ] && cmd_rewind 10
[ $1 == "fast-rewind" ] && cmd_rewind 60

[ $1 == "next" ] && cmd_next 30
[ $1 == "previous" ] && cmd_previous 30

[ $1 == "inc-vol" ] && cmd_incvolume 10
[ $1 == "max-vol" ] && cmd_incvolume 70
[ $1 == "dec-vol" ] && cmd_decvolume 10
[ $1 == "min-vol" ] && cmd_decvolume 30

[ $1 == "subtitle-on" ] && cmd_subtitle 1
[ $1 == "subtitle-off" ] && cmd_subtitle 0
