#! /bin/bash
#
# Discharging to:
# <10% 
# 10% 󰁺 
# 20% 󰁻 
# 30% 󰁼 
# 40% 󰁽 
# 50% 󰁾 
# 60% 󰁿 
# 70% 󰂀 
# 80% 󰂁 
# 90% 󰂂 
# Full 
#
# Charging to:
# 10% 󰢜 
# 20% 󰂆 
# 30% 󰂇 
# 40% 󰂈 
# 50% 󰢝 
# 60% 󰂉 
# 70% 󰢞 
# 80% 󰂊 
# 90% 󰂋 
# 100% 󰂅
# Done 󱟣
#
# Bluetooth : 󰂯
# Laptop    :  
# Phone     :  
# Headphone : 󰋋

STATE="Unknown"
PERCENTAGE1=0
PERCENTAGE2=0
PERCENTAGE3=0
TIMEOUT=$(( 5 * 60 ))  # 5 minutes
STEP=3

notification() {
	hyprctl notify $1 3000 "rgb(1f494b)" "fontsize:28    $2%"
  # 0 - Alert
  # 1 - Hint
  # 2 - Idea
  # 3 - Error
  # 4 - Question
  # 5 - Tick
}

HEADPHONE_IP="B4:9A:95:B0:73:28"
PHONE_IP="C0:47:54:72:BB:9A"

check() {
  STATE=`acpi -b | cut -d ' ' -f 3-3 | cut -d ',' -f 1-1`
  PERCENTAGE1=`acpi -b | cut -d ',' -f 2-2 | cut -d ' ' -f 2-2 | cut -d '%' -f 1-1`
  PERCENTAGE2=`bluetoothctl info $PHONE_IP | grep "Battery" | cut -d '(' -f 2-2 | cut -d ')' -f 1-1`
  PERCENTAGE3=`bluetoothctl info $HEADPHONE_IP | grep "Battery" | cut -d '(' -f 2-2 | cut -d ')' -f 1-1`
}

update_battery() {

  case ${PERCENTAGE1} in
    0|1|2|3|4|5|6|7|8|9)
      [ ${STATE} = "Discharging" ] && ICON1=" "|| ICON1="󰢜 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 3 " ${ICON1}${PERCENTAGE1}"
      ;;
    10|11|12|13|14|15|16|17|18|19)
      [ ${STATE} = "Discharging" ] && ICON1="󰁺 "|| ICON1="󰂆 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 3 " ${ICON1}${PERCENTAGE1}"
      ;;
    20|21|22|23|24|25|26|27|28|29)
      [ ${STATE} = "Discharging" ] && ICON1="󰁻 "|| ICON1="󰂇 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 0 " ${ICON1}${PERCENTAGE1}"
      ;;
    30|31|32|33|34|35|36|37|38|39)
      [ ${STATE} = "Discharging" ] && ICON1="󰁼 "|| ICON1="󰂈 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 0 " ${ICON1}${PERCENTAGE1}"
      ;;
    40|41|42|43|44|45|46|47|48|49)
      [ ${STATE} = "Discharging" ] && ICON1="󰁽 "|| ICON1="󰢝 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 1 " ${ICON1}${PERCENTAGE1}"
      ;;
    50|51|52|53|54|55|56|57|58|59)
      [ ${STATE} = "Discharging" ] && ICON1="󰁾 "|| ICON1="󰂉 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 1 " ${ICON1}${PERCENTAGE1}"
      ;;
    60|61|62|63|64|65|66|67|68|69)
      [ ${STATE} = "Discharging" ] && ICON1="󰁿 "|| ICON1="󰢞 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 " ${ICON1}${PERCENTAGE1}"
      ;;
    70|71|72|73|74|75|76|77|78|79)
      [ ${STATE} = "Discharging" ] && ICON1="󰂀 "|| ICON1="󰂊 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 " ${ICON1}${PERCENTAGE1}"
      ;;
    80|81|82|83|84|85|86|87|88|89)
      [ ${STATE} = "Discharging" ] && ICON1="󰂁 "|| ICON1="󰂋 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 " ${ICON1}${PERCENTAGE1}"
      ;;
    90|91|92|93|94|95|96|97|98|99)
      [ ${STATE} = "Discharging" ] && ICON1="󰂁 "|| ICON1="󰂅 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 5 " ${ICON1}${PERCENTAGE1}"
      ;;
    100)
      [ ${STATE} = "Discharging" ] && ICON1=" " || ICON1="󱟣 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 5 " ${ICON1}${PERCENTAGE1}"
      ;;
  esac
  
}

update_phone() {

  case ${PERCENTAGE2} in
    0|1|2|3|4|5|6|7|8|9)
      ICON2="󰂯  "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 3 "${ICON2}${PERCENTAGE2}"
      ;;
    10|11|12|13|14|15|16|17|18|19)
      ICON2="󰂯󰁺 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 3 "${ICON2}${PERCENTAGE2}"
      ;;
    20|21|22|23|24|25|26|27|28|29)
      ICON2="󰂯󰁻 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 0 "${ICON2}${PERCENTAGE2}"
      ;;
    30|31|32|33|34|35|36|37|38|39)
      ICON2="󰂯󰁼 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 0 "${ICON2}${PERCENTAGE2}"
      ;;
    40|41|42|43|44|45|46|47|48|49)
      ICON2="󰂯󰁽 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 1 "${ICON2}${PERCENTAGE2}"
      ;;
    50|51|52|53|54|55|56|57|58|59)
      ICON2="󰂯󰁾 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 1 "${ICON2}${PERCENTAGE2}"
      ;;
    60|61|62|63|64|65|66|67|68|69)
      ICON2="󰂯󰁿 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 "${ICON2}${PERCENTAGE2}"
      ;;
    70|71|72|73|74|75|76|77|78|79)
      ICON2="󰂯󰂀 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 "${ICON2}${PERCENTAGE2}"
      ;;
    80|81|82|83|84|85|86|87|88|89)
      ICON2="󰂯󰂁 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 "${ICON2}${PERCENTAGE2}"
      ;;
    90|91|92|93|94|95|96|97|98|99)
      ICON2="󰂯󰂁 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 5 "${ICON2}${PERCENTAGE2}"
      ;;
    100)
      ICON2="󰂯  "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 5 "${ICON2}${PERCENTAGE2}"
      ;;
  esac
}

update_headphone() {

  case ${PERCENTAGE3} in
    0|1|2|3|4|5|6|7|8|9)
      ICON3="󰂯  "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 3 "${ICON3}${PERCENTAGE3}"
      ;;
    10|11|12|13|14|15|16|17|18|19)
      ICON3="󰂯󰁺 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 3 "${ICON3}${PERCENTAGE3}"
      ;;
    20|21|22|23|24|25|26|27|28|29)
      ICON3="󰂯󰁻 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 0 "${ICON3}${PERCENTAGE3}"
      ;;
    30|31|32|33|34|35|36|37|38|39)
      ICON3="󰂯󰁼 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 0 "${ICON3}${PERCENTAGE3}"
      ;;
    40|41|42|43|44|45|46|47|48|49)
      ICON3="󰂯󰁽 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 1 "${ICON3}${PERCENTAGE3}"
      ;;
    50|51|52|53|54|55|56|57|58|59)
      ICON3="󰂯󰁾 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 1 "${ICON3}${PERCENTAGE3}"
      ;;
    60|61|62|63|64|65|66|67|68|69)
      ICON3="󰂯󰁿 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 "${ICON3}${PERCENTAGE3}"
      ;;
    70|71|72|73|74|75|76|77|78|79)
      ICON3="󰂯󰂀 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 "${ICON3}${PERCENTAGE3}"
      ;;
    80|81|82|83|84|85|86|87|88|89)
      ICON3="󰂯󰂁 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 2 "${ICON3}${PERCENTAGE3}"
      ;;
    90|91|92|93|94|95|96|97|98|99)
      ICON3="󰂯󰂁 "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 5 "${ICON3}${PERCENTAGE3}"
      ;;
    100)
      ICON3="󰂯  "
      [ ! -z "$1" ] && [ "$1" = "notify" ] && notification 5 "${ICON3}${PERCENTAGE3}"
      ;;
  esac
}

notify_it() {

  if [ -z $PERCENTAGE2 ] && [ -z $PERCENTAGE3 ]; then
    notify-send "  ${ICON1}${PERCENTAGE1}%"
  elif [ -z $PERCENTAGE2 ]; then
    notify-send "  ${ICON1}${PERCENTAGE1}%, 󰋋 ${ICON3}${PERCENTAGE3}%"
  elif [ -z $PERCENTAGE3 ]; then
    notify-send "  ${ICON1}${PERCENTAGE1}%,  ${ICON2}${PERCENTAGE2}%"
  else
    notify-send "  ${ICON1}${PERCENTAGE1}%,  ${ICON2}${PERCENTAGE2}%, 󰋋 ${ICON3}${PERCENTAGE3}%"
  fi
}

print_it() {

  if [ -z $PERCENTAGE2 ] && [ -z $PERCENTAGE3 ]; then
    echo "  ${ICON1}${PERCENTAGE1}%"
  elif [ -z $PERCENTAGE2 ]; then
    echo "  ${ICON1}${PERCENTAGE1}%, 󰋋 ${ICON3}${PERCENTAGE3}%"
  elif [ -z $PERCENTAGE3 ]; then
    echo "  ${ICON1}${PERCENTAGE1}%,  ${ICON2}${PERCENTAGE2}%"
  else
    echo "  ${ICON1}${PERCENTAGE1}%,  ${ICON2}${PERCENTAGE2}%, 󰋋 ${ICON3}${PERCENTAGE3}%"
  fi
}

update() {
  check

  if [ ! -z "$1" ] && [ "$1" = "notify" ];then
    update_battery $*
    update_phone $*
    update_headphone $*
  elif [ ! -z "$1" ] && [ "$1" = "custom" ]; then
    update_headphone $*
    update_phone $*
    update_battery $*
    notify_it
  else
    update_battery
    update_phone
    update_headphone
  fi
}

ping() {
    bluetoothctl devices | grep $HEADPHONE_IP
    if [ $? -eq 0 ]; then
      bluetoothctl --timeout $STEP connect $HEADPHONE_IP
    fi

    bluetoothctl devices | grep $PHONE_IP
    if [ $? -eq 0 ]; then
      bluetoothctl --timeout $STEP connect $PHONE_IP
    fi
}

COUNT=`pgrep -c battery.sh`
if [ $COUNT -le 1 ]; then

  TICK=$(( ${TIMEOUT} - 30 ))
  while true; do
    ping

    if [ $TICK -ge $TIMEOUT ]; then
      update custom
      TICK=0
    fi

    sleep $STEP
    TICK=$(( $TICK + $(( 3 * $STEP )) ))
  done

else
  update $*
  print_it
fi
