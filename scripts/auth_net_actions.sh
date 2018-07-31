#!/bin/bash

action=$1


IFNAME="wlp2s0"

case "${action}" in 
	reconfigure)
		vi /etc/wpa_supplicant/wpa_supplicant.conf
		;;&
	reload)
		wpa_cli -i "${IFNAME}" reconfigure
		;;
	renew)
		dhclient -r "${IFNAME}"
		;;
	scan)
		wpa_cli -i "${IFNAME}" scan_results
		read -p "Enter to continue.ss:q
		;;
esac
		

