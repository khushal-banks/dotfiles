#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"
MOVIE_LOGS="/home/iCode/media/logs/movie.log"

COUNT=`pgrep -c movie.sh`
[ $COUNT -gt 1 ] && exit

LAST=`cat $MOVIE_LOGS | tail -n 1` || exit
if [ ! -z "$LAST" ]; then
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
  mpv "$LAST"
fi

while true; do
  FILE=`find -L /home/iCode/media/torrent/Collection -type f | fzf`
	[ -z "$FILE" ] && continue

  echo "$FILE" >> $MOVIE_LOGS
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
	mpv "$FILE"
done
