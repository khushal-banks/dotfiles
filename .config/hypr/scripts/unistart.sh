#! /bin/bash

PID=$(pgrep $1)

if [ -z $PID ]; then
       	$1 &
else
	pkill $1
fi
