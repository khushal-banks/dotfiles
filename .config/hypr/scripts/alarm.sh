#! /bin/bash

DATE=`date "+%b-%d_%I-%M%p"`
[ -z $1 ] && CHANGE_WALLPAPER=0 || CHANGE_WALLPAPER=1

check() {
	TIME=`date "+%b %d, %I:%M %p [%a-%V/52]"`
	QUOTE=`motivate | sed $'s/\033\[[0-9;]*m//g'`

	notify-send -u critical "󱀡 $QUOTE     "
}

COUNT=`pgrep -c alarm.sh`
if [ $COUNT -le 1 ]; then
	while true; do
		MIN=`date "+%M"`
		if [ $MIN -eq 00 ]; then
			[ $CHANGE_WALLPAPER -eq 1 ] && /home/iCode/.config/hypr/scripts/wallpaper.sh white-collar1.png
      check
			sleep 60
    elif [ $MIN -eq 20 ]; then
			[ $CHANGE_WALLPAPER -eq 1 ] && /home/iCode/.config/hypr/scripts/wallpaper.sh breaking-bad2.png
      check
			sleep 60
    elif [ $MIN -eq 40 ]; then
			[ $CHANGE_WALLPAPER -eq 1 ] && /home/iCode/.config/hypr/scripts/wallpaper.sh batman-ultra3.png
      check
			sleep 60
		else
			sleep 5
		fi
	done
else
	check
fi
