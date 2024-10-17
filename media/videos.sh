#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"
VIDEO_LOGS="/home/iCode/media/logs/videos.log"

COUNT=`pgrep -c videos.sh`
# [ $COUNT -gt 1 ] && exit

cd /home/iCode/media/youtube/Collection/

LAST=`cat $VIDEO_LOGS | tail -n 1` || exit
if [ ! -z "$LAST" ]; then
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
  mpv --loop "$LAST"
fi

while true; do
  FILE=`find -L . -type f | fzf --keep-right --reverse --bind '::jump-accept' -e -i`
	if [ -z "$FILE" ]; then
    read -t 3 -rN 1 confirm && [ $confirm = $'\e' ] && exit || continue
  fi

  echo "$FILE" >> $VIDEO_LOGS
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
	mpv --loop "$FILE"
done
