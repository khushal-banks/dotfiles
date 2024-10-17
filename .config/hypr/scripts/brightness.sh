#! /bin/bash
#
# Brightness Levels:
# 1. Increasing Order:       󰽡,        
# 2. Decreasing Order:       ,        

INC_STEP=5
DEC_STEP=10
LIMIT_MIN=5
LIMIT_MAX=100
LIMIT_DN=30
LIMIT_UP=60

check() {
	LIGHT=$(printf "%.0f\n" $(brightnessctl g))
	MAX=$(printf "%.0f\n" $(brightnessctl m))
  PERCENTAGE=$(( ${LIGHT} * 100 / ${MAX} ))

  case ${PERCENTAGE} in
    0|1|2|3|4|5|6) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    7|8|9|10|11|12|13) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    14|15|16|17|18|19|20) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    21|22|23|24|25|26|27) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    28|29|30|31|32|33|34) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    35|36|37|38|39|40|41) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    42|43|44|45|46|47|48) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    49|50|51|52|53|54|55) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON="󰽡 " ;;
    56|57|58|59|60|61|62) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    63|64|65|66|67|68|69) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    70|71|72|73|74|75|76) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    77|78|79|80|81|82|83) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    84|85|86|87|88|89|90) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    91|92|93|94|95|96|97) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" "|| ICON=" " ;;
    98|99|100) [ ! -z "$1" ] && [ "$1" = "--dec" ] && ICON=" " || ICON=" " ;;
  esac
}

notification() {
	hyprctl notify $1 1500 "rgb(1f494b)" "fontsize:28   : 󰹑 $2% ${ICON} "
  # 0 - Alert
  # 1 - Hint
  # 2 - Idea
  # 3 - Error
  # 4 - Question
  # 5 - Tick
}

print_it() {
	echo "${PERCENTAGE}%"
  notification 4 "${PERCENTAGE}"
}

limit_min() {
	brightnessctl set ${LIMIT_DN}%
  check "--max"
  notification 2 "${PERCENTAGE}"
}

limit_max() {
	brightnessctl set ${LIMIT_UP}%
  check "--min"
  notification 2 "${PERCENTAGE}"
}

decrease() {
	# Decrease only upto LIMIT_MIN
  [[ $(( ${PERCENTAGE} - ${DEC_STEP} )) -le ${LIMIT_MIN} ]] && brightnessctl set ${LIMIT_MIN}% || brightnessctl set ${DEC_STEP}%-
  check "--dec"

  if [ ${PERCENTAGE} -lt ${LIMIT_DN} ]; then
    notification 4 "${PERCENTAGE}"
  elif [ ${PERCENTAGE} -gt ${LIMIT_UP} ]; then
    notification 3 "${PERCENTAGE}"
  else
    notification 5 "${PERCENTAGE}"
  fi
}

increase() {
	# Increase only upto LIMIT_MAX
	[[ $(( ${PERCENTAGE} + ${INC_STEP} )) -ge ${LIMIT_MAX} ]] && brightnessctl set ${LIMIT_MAX}% || brightnessctl set ${INC_STEP}%+
  check "--inc"

  if [ ${PERCENTAGE} -lt ${LIMIT_DN} ]; then
    notification 4 "${PERCENTAGE}"
  elif [ ${PERCENTAGE} -gt ${LIMIT_UP} ]; then
    notification 3 "${PERCENTAGE}"
  else
    notification 5 "${PERCENTAGE}"
  fi
}

check
if [[ "$1" == "--get" ]]; then
  print_it
elif [[ "$1" == "--min" ]]; then
	limit_min
elif [[ "$1" == "--max" ]]; then
	limit_max
elif [[ "$1" == "--dec" ]]; then
	decrease
elif [[ "$1" == "--inc" ]]; then
	increase
fi
