#! /bin/bash
#
# wlogout --protocol layer-shell
# waybar would also need theme selection

PID=$(pgrep $1)

if [ -z $PID ]; then
    $* &
else
	pkill $1
fi
