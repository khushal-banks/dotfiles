#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"
MUSIC_LOGS="/home/iCode/media/logs/music.log"

COUNT=`pgrep -c music.sh`
[ $COUNT -gt 1 ] && exit

cd /home/iCode/media/playlist/

LAST=`cat $MUSIC_LOGS | tail -n 1` || exit
if [ ! -z "$LAST" ]; then
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
  mpv --loop "$LAST"
fi

while true; do
  FILE=`find -L . -type f | fzf --keep-right --reverse --bind '::jump-accept' --query=lofi_music/ -e -i`
	if [ -z "$FILE" ]; then
    read -t 3 -rN 1 confirm && [ $confirm = $'\e' ] && exit || continue
  fi

  echo "$FILE" >> $MUSIC_LOGS
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
	mpv --loop "$FILE"
done
