#! /bin/bash
#
# wlogout --protocol layer-shell
# waybar would also need theme selection

PID=$(pgrep $1)

if [ -z $PID ]; then
       	$1 &
else
	pkill $1
fi
