#! /bin/bash

SCRIPT="/home/iCode/.config/hypr/scripts/multitask.sh"

[ -z $1 ] && exit 
cd playlist

${SCRIPT} stop
sleep 0.1
${SCRIPT} start
ytfzf -t "$*"
