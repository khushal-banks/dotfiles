#! /bin/bash

languages=`echo c zig cpp golang rust python bash lua angular react typescript javascript nodejs expressjs html css | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query
if printf $languages | grep -qs $selected; then
  curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done
else
  curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done
fi
