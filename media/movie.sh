#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"
MOVIE_LOGS="/home/iCode/media/logs/movie.log"

COUNT=`pgrep -c movie.sh`
[ $COUNT -gt 1 ] && exit

cd /home/iCode/media/torrent/Collection/

LAST=`cat $MOVIE_LOGS | tail -n 1` || exit
if [ ! -z "$LAST" ]; then
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
  mpv "$LAST"
fi

# Common File types to remove:
# cip
# xml
# pac
# srt
# stl
# sub
# md
# txt
# png
# jpg
# jpeg
# pdf
# docx
# doc
# xls
# xl

while true; do
  FILE=`find -L . -type f \( -not -name '*.cip' -a -not -name '*.xml' -a -not -name '*.pac' -a -not -name '*.srt' -a -not -name '*.stl' -a -not -name '*.sub' -a -not -name '*.md' -a -not -name '*.txt' \) | fzf --keep-right --reverse --bind '::jump-accept' -e -i`
	if [ -z "$FILE" ]; then
    read -t 3 -rN 1 confirm && [ $confirm = $'\e' ] && exit || continue
  fi

  echo "$FILE" >> $MOVIE_LOGS
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
	mpv "$FILE"
done
