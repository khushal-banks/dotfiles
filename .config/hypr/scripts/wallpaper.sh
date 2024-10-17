#! /bin/bash

cd /home/iCode/.config/hypr/scripts/
SELECTED=$(readlink -f current | cut -d '/' -f 7-8)

modify_selection() {
	[ $SELECTED == "selected/white-collar1.png" ] && SELECTED="selected/breaking-bad2.png" && echo $SELECTED && return
	[ $SELECTED == "selected/breaking-bad2.png" ] && SELECTED="selected/batman-ultra3.png" && echo $SELECTED && return
	[ $SELECTED == "selected/batman-ultra3.png" ] && SELECTED="selected/white-collar1.png" && echo $SELECTED && return

	SELECTED="selected/white-collar1.png"
}

update() {
	unlink current
	ln -s $SELECTED current

  pkill hyprpaper
	swww img -o eDP-1 current --transition-duration 2 --transition-type wipe --transition-fps 60
}

overload() {
	cp /home/iCode/.config/hypr/scripts/current /etc/default/background/grub-background.png
	cp /home/iCode/.config/hypr/scripts/current /usr/share/sddm/themes/sdt/wallpaper.jpg
}


[ ! -z $1 ] && SELECTED="selected/$1" || modify_selection
update
overload
