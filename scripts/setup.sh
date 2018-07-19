#!/bin/bash

function listSW()
{
#admin tools
	cat <<-EOF
		apt-file
		screen
		gnuplot
		whois
		vim
		krb5-user
		cifs-utils
		vifm
		sshfs
	EOF
#apps:
	cat <<-EOF
		firefox
		libreoffice
		thunderbird
		vlc
		zathura
		asunder
		inkscape
		wodim
		kicad
		feh
		qemu
	EOF
#dev tools:
	cat <<-EOF
		git
		g++
	EOF
#windows manager env:
	cat <<-EOF
		i3-wm
		i3status
		i3lock
		rxvt-unicode
		xinput
		xinit
		x11-xserver-utils
		suckless-tools
		x11-apps
	EOF
#wifi support
	cat <<-EOF
		wireless-tools
		wpasupplicant
	EOF
#audio support
	cat <<-EOF
		alsa-utils
		pulseaudio
		EOF
}

function addPPAs()
{
	sudo add-apt-repository --yes ppa:js-reynaud/ppa-kicad
	sudo apt update
#sudo apt install kicad
}

function installArduino()
{
	VER=1.8.5
	wget "https://downloads.arduino.cc/arduino-${VER}-linux64.tar.xz"
	#unzip and install:
	tar xf arduino-${VER}-linux64.tar.xz
	sudo mv arduino-${VER} /usr/local
	sudo ln -s /usr/local/arduino-${VER}/adruino /usr/local/bin

	rm arduino-${VER}-linux64.tar.xz

}

function nonIntegratedSW()
{
#arduino
	installArduino
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

	ln -s /home/will/config/i3/config ~/.config/i3/config
	ln -s /home/will/config/i3/i3status.conf ~/.i3status.conf
	ln -s /home/will/config/vimrc ~/.vimrc
	ln -s /home/will/config/Xresources ~/.Xresources
	ln -s /home/will/config/scripts ~/scripts
}

function rxvt_hack()
{
#someone's missed the rxvt-unicode-256color file out of the terminfo DB, or it's lost in ubuntu 18.04...  assume it's close to the non-unicode color term...
	sudo cp /usr/share/terminfo/r/rxvt-256color /usr/share/terminfo/r/rxvt-unicode/256color
}


addPPAs
installSW
config
rxvt_hack
