#! /bin/bash

STEP=5
LIMIT_MIN=5
LIMIT_MAX=100

minimum() {
	brightnessctl set 25%
}

maximum() {
	brightnessctl set 50%
}

check() {
	LIGHT=$(printf "%.0f\n" $(brightnessctl g))
	MAX=$(printf "%.0f\n" $(brightnessctl m))
	PERCENT=$(( ${LIGHT} * 100 / ${MAX} ))

}

decrease() {
	# Decrease only upto LIMIT_MIN
	[[ $(( ${PERCENT} - ${STEP} )) -le ${LIMIT_MIN} ]] && brightnessctl set ${LIMIT_MIN}% || brightnessctl set ${STEP}%-
}

increase() {
	# Increase only upto LIMIT_MAX
	[[ $(( ${PERCENT} + ${STEP} )) -ge ${LIMIT_MAX} ]] && brightnessctl set ${LIMIT_MAX}% || brightnessctl set ${STEP}%+
}

check
if [[ "$1" == "--get" ]]; then
	echo "${PERCENT}%"
elif [[ "$1" == "--min" ]]; then
	minimum
elif [[ "$1" == "--max" ]]; then
	maximum
elif [[ "$1" == "--dec" ]]; then
	decrease
elif [[ "$1" == "--inc" ]]; then
	increase
fi
