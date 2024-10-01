#! /bin/bash

LANG=en

[ -z $1 ] && exit
if [ $1 != "hin" ] && [ $1 != "en" ]; then
	exit
fi

[ $1 == "hin" ] && LANG=hin
shift

[ -z $1 ] && CONTENT="$QUTE_SELECTED_TEXT" || CONTENT="$*"

TRANSLATION=`trans :$LANG -show-original=n -show-translation=n -show-languages=n -show-prompt-message=n -show-original-dictionary=n -show-dictionary=n -show-alternatives=Y -indent 1 "$CONTENT" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g"`

notify-send "$TRANSLATION"
