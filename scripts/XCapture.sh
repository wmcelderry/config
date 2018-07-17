#!/bin/bash

ID="${1}"

function getGeo()
{
	ID="${1}"

	xrandr | grep \\\<connected | awk '{geo=($3=="primary" ? $4 : $3) ; if($1 == "'${ID}'") print geo;}';
}

xwd -root | convert -crop "$(getGeo ${ID})" xwd:- "$HOME/Pictures/Screenshot-$(date +"%y-%m-%d_%H:%M:%S").png"



#window:
#get geom of current active window
#xwininfo -id $(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}') | awk '/Corners/{split($2,b,"+");print b[3]}'
#which output is it on:
#xrandr | grep \\\<connected
