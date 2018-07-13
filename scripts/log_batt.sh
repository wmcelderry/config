#!/bin/bash

FREQ=10m

while true
do
	echo $(date "+%d-%m-%Y %H:%M:%S") $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/energy:/ {e=$2;} /percentage:/{p=$2;}  /voltage:/ {v=$2;} /energy-full:/ {f=$2;} END {print f, e , p, v;}') >> ~/battery.log
	sleep ${FREQ}
done

