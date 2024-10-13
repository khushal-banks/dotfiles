#! /bin/bash

DATE=`date "+%b-%d_%I-%M%p"`
FILE="/home/iCode/.hyper-base/quotes${DATE}.backup"

check() {
	TIME=`date "+%b %d, %I:%M %p [%a-%V/52]"`
	QUOTE=`motivate | sed $'s/\033\[[0-9;]*m//g'`

	echo "${QUOTE}" >> ${FILE}
	notify-send "󰥔 $TIME"
	notify-send -u critical "$QUOTE"
}

COUNT=`pgrep -c alarm.sh`
if [ $COUNT -le 1 ]; then
	while true; do
		MIN=`date "+%M"`
		if [ $MIN -eq 00 ] || [ $MIN -eq 20 ] || [ $MIN -eq 40 ]; then
			/home/iCode/.config/hypr/scripts/wallpaper.sh
      check
			sleep 60
		else
			sleep 5
		fi
	done
else
	check
fi
