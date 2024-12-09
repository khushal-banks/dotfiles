#!/usr/bin/env bash
#
# This script is designed to easily switch tofi-themes at run-time

FAIL=1
PASS=0
WORKING_DIR="${HOME}/.config/tofi"
cd "${WORKING_DIR}" || exit $FAIL

usage(){
    echo
    echo "Usage:"
    echo "${0} [theme]"
    echo

    COUNT=0
    echo "Available themes:"
    for THEME in "${THEMES[@]}"
    do
	COUNT=$(( COUNT + 1 ))
	NAME=$(echo $THEME | cut -f 2-2 -d '/')
        echo "${COUNT}) ${NAME}"
    done
}

update(){

    for THEME in "${THEMES[@]}"
    do
        if [ "${THEME}" = "${THEMES_DIR}/${TARGET_THEME}" ]; then
    	    unlink ${TARGET_LINK}
    	    ln -s ${THEME} ${TARGET_LINK}
            return $?
        fi
    done
    return $FAIL
}

THEMES_DIR="themes"
THEMES=($(ls -d ${THEMES_DIR}/*))

[ -z $1 ] && usage && exit $FAIL
TARGET_LINK="theme"

case "$1" in
    "--get"|"--path")
	[ ! -f ${TARGET_LINK} ] && exit $FAIL

	THEME_PATH=$(readlink -f ${TARGET_LINK})
	THEME_NAME=$(basename ${THEME_PATH})
	[ "$1" = "--path" ] && echo "${THEME_PATH}" || echo "${THEME_NAME}"
        ;;
    *)
        TARGET_THEME="$1"
        update
        ;;
esac
