#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"
cd Collection

FILE=`find -L ../links/ -type f | fzf --keep-right --reverse --bind '::jump-accept' -e -i`
[ -z $FILE ] && exit

download() {
	yt-dlp -c -f best -a $FILE
	# yt-dlp -c -a $FILE
}

stream() {
	CONTENT=`cat $FILE`
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
	yt-dlp -o - $CONTENT | mpv -
}

# No arguments: also means Download
# Pass something like stream (or any unknown value) for streaming
[ -z "$1" ] && download && exit
[ "$1" == "-d" ] && download && exit
[ "$1" == "d" ] && download && exit
[ "$1" == "download" ] && download && exit
[ "$1" == "--download" ] && download && exit
[ "$1" == "Download" ] && download && exit
[ "$1" == "--Download" ] && download && exit

stream
