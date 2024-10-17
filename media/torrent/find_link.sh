#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"
cd Collection

FILE=`find -L ../links/ -type f | fzf --keep-right --reverse --bind '::jump-accept' -e -i`
[ -z $FILE ] && exit

CONTENT=`cat $FILE`

confirm_with_info() {
  webtorrent info $CONTENT
  echo
  read -p "Continue ? (y/n): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit 1
  fi
}

download() {
	webtorrent download $CONTENT
}

stream() {
  ${SCRIPT} stop
  sleep 0.1
  ${SCRIPT} start
  webtorrent download ${CONTENT} --mpv
}

confirm_with_info

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
