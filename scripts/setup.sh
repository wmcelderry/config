#!/bin/bash

function listSW()
{
	cat <<-EOF
		screen
		firefox
		qemu
		libreoffice
		git
		g++
		i3wm
		thunderbird
		rxvt-unicode
		vim
		krb5-user
		cifs-utils
		vlc
		vifm
		sshfs
		kicad
		zathura
		asunder
		wodim
		inkscape
		EOF
}

function addPPAs()
{
}


function installSW()
{
	sudo apt update
	sudo apt install -y $(listSW)
}


function genKey()
{
	ssh-keygen
}


function config()
{
	git clone https://gitlab.com/wmcelderry/config

	ln -s /home/will/config/i3 ~/.config/i3
	ln -s /home/will/config/vimrc ~/.vimrc
	ln -s /home/will/config/Xresources ~/.Xresources
	ln -s /home/will/config/scripts ~/scripts
}
