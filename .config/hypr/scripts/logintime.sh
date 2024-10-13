#! /bin/bash

USER=`whoami`

LINE1=`last | grep tty1 | grep $USER | head -n1 | tail -n1 | cut -c 40-`
LINE2=`last | grep tty1 | grep $USER | head -n2 | tail -n1 | cut -c 40-`
LINE3=`last | grep tty1 | grep $USER | head -n3 | tail -n1 | cut -c 40-`
LINE4=`last | grep tty1 | grep $USER | head -n4 | tail -n1 | cut -c 40-`
LINE5=`last | grep tty1 | grep $USER | head -n5 | tail -n1 | cut -c 40-`

# notify-send -t 3000 "$LINE5"
# notify-send -t 3000 "$LINE4"
# notify-send -t 3000 "$LINE3"
# notify-send -t 3000 "$LINE2"
# notify-send -t 3000 "$LINE1"

notification() {
	hyprctl notify $1 7000 "rgb(1f494b)" "fontsize:28   - $2"
	sleep 0.18
}

notification 5 "$LINE1"
notification 1 "$LINE2"
notification 1 "$LINE3"
# notification 1 "$LINE4"
# notification 1 "$LINE5"
