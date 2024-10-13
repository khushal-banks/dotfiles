#! /bin/bash

[ -z $1 ] && exit 
cd playlist
ytfzf -t "$*"
