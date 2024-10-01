#! /bin/bash

cd /home/iCode/.config/hypr/scripts/
SELECTED=$(readlink -f current | cut -d '/' -f 7-8)

modify_selection() {
	[ $SELECTED == "selected/batman-ultra1.png" ] && SELECTED="selected/batman-ultra2.png" && echo $SELECTED && return
	[ $SELECTED == "selected/batman-ultra2.png" ] && SELECTED="selected/batman-ultra3.png" && echo $SELECTED && return
	[ $SELECTED == "selected/batman-ultra3.png" ] && SELECTED="selected/batman-ultra1.png" && echo $SELECTED && return

	SELECTED="selected/batman-ultra1.png"
}

update() {
	unlink current
	ln -s $SELECTED current

	swww img -o eDP-1 current --transition-step 10 --transition-fps 20
}

overload() {
	cp /home/iCode/.config/hypr/scripts/current /etc/default/background/grub-background.png
	cp /home/iCode/.config/hypr/scripts/current /usr/share/sddm/themes/sdt/wallpaper.jpg
}

modify_selection
update
overload
