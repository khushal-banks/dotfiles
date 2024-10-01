#! /bin/bash

USER=`whoami`

LINE1=`last | grep $USER | head -n1 | tail -n1 | cut -c 40-`
LINE2=`last | grep $USER | head -n2 | tail -n1 | cut -c 40-`
LINE3=`last | grep $USER | head -n3 | tail -n1 | cut -c 40-`

notify-send -t 3000 "$LINE3"
notify-send -t 3000 "$LINE2"
notify-send -t 3000 "$LINE1"
