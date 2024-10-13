#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"
MUSIC_LOGS="/home/iCode/media/logs/music.log"

COUNT=`pgrep -c music.sh`
[ $COUNT -gt 1 ] && exit

LAST=`cat $MUSIC_LOGS | tail -n 1` || exit
if [ ! -z "$LAST" ]; then
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
  mpv "$LAST"
fi

while true; do
  FILE=`find -L /home/iCode/media/playlist/ -type f | fzf`
	[ -z "$FILE" ] && continue

  echo "$FILE" >> $MUSIC_LOGS
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
	mpv "$FILE"
done
