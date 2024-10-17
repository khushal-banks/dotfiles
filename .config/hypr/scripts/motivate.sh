#! /bin/bash

TIME=`date "+%b %d, %I:%M %p [%a-%V/52]"`
QUOTE=`cat /usr/share/motivate/quotes.txt | fzf`
[ -z "$QUOTE" ] && exit

echo "$QUOTE" | wl-copy
# notify-send "󰥔 $TIME"
notify-send -u critical "󱀡 $QUOTE     "
