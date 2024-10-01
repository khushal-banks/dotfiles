#! /bin/bash

while true; do
	MIN=`date "+%M"`
	if [ $MIN -eq 00 ] || [ $MIN -eq 20 ] || [ $MIN -eq 40 ]; then
		/home/iCode/.config/hypr/scripts/wallpaper.sh

		TIME=`date "+%I:%M %p - %A"`
		QUOTE=`fortune -n 80`
notify-send "$TIME

$QUOTE"
		sleep 60
	else
		sleep 5
	fi
done
