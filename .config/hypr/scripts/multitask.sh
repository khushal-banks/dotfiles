#! /bin/bash

STATUS=$(readlink -f /home/iCode/.config/hypr/run-time/multitask | cut -d '/' -f 7-7)

multitask_off() {
	cd /home/iCode/.config/hypr/run-time/;
	unlink multitask
	ln -s multitask_off multitask
	cd - >> /dev/null
	tmux set status on
}

multitask_on() {
	cd /home/iCode/.config/hypr/run-time/;
	unlink multitask
	ln -s multitask_on multitask
	cd - >> /dev/null
	tmux set status off
}

multitask_cold() {
	multitask_on

	cd /home/iCode/.config/mpv/;
	echo `cat mpvHistory.log | tail -n1 | cut -d ']' -f 2-2 | cut -d '[' -f 1-1 | cut -d ' ' -f 2-`
	cd - >> /dev/null
}

cmd_start() {
	multitask_on
}

cmd_stop() {
	echo '{ "command": ["quit"] }' | socat - /tmp/mpvsocket
	multitask_off
}

cmd_pause() {
	echo '{ "command": ["cycle", "pause"] }' | socat - /tmp/mpvsocket
	[ $STATUS == "multitask_off" ] && multitask_on || multitask_off
}

cmd_forward() {
	[ $1 -eq 10 ] && echo '{ "command": ["seek", "+10"] }' | socat - /tmp/mpvsocket || echo '{ "command": ["seek", "+30"] }' | socat - /tmp/mpvsocket
}

cmd_backward() {
	[ $1 -eq 10 ] && echo '{ "command": ["seek", "-10"] }' | socat - /tmp/mpvsocket || echo '{ "command": ["seek", "-30"] }' | socat - /tmp/mpvsocket
}

[ -z $1 ] && exit
[ $1 == "stop" ] && cmd_stop
[ $1 == "pause" ] && cmd_pause
[ $1 == "start" ] && cmd_start
[ $1 == "cold" ] && multitask_cold
[ $1 == "step-forward" ] && cmd_forward 10
[ $1 == "jump-forward" ] && cmd_forward 30
[ $1 == "step-backward" ] && cmd_backward 10
[ $1 == "jump-backward" ] && cmd_backward 30
