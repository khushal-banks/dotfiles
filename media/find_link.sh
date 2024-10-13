#! /bin/bash

cd Collection

FILE=`find -L ../links/ -type f | fzf`
[ -z $FILE ] && exit

download() {
	yt-dlp -c -f best -a $FILE
}

stream() {
	CONTENT=`cat $FILE`
	yt-dlp -o - $CONTENT | mpv -
}

[ -z "$1" ] && download && exit
[ "$1" == "d" ] && download && exit

stream
