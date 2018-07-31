#!/bin/bash
mode=$1

case "$mode" in 
	default)
		(
		sed '/^mode /,/^}/d;/^set/d;/^for_window/d;/^exec/d;/^bar/,/^}/d;/^$/d;/^#HelpText/,/#\/HT/p;/^#/d;d' /home/will/config/i3/config
		cat <<-EOF



		EOF
		sed -n '/^mode /p' /home/will/config/i3/config 
		cat <<-EOF



		EOF
		sed '/^mode /,/^}/d;/^set/d;/^for_window/d;/^exec/d;/^bar/,/^}/d;/^$/d;/^#/d' /home/will/config/i3/config
		)| less
		;;
	*)
		sed -n '/mode "'"${mode}"'"/,/^}/p' ~/config/i3/config | less
		;;
esac
