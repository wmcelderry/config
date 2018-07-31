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
		bridge-utils
		lsof
		tcpdump
		upower
		openssh-server
		openvpn
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
		qemu-kvm
		linphone
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
		hostapd
	EOF
#bluetooth support:
	cat <<-EOF
		bluez
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

	sudo tee -a /usr/local/arduino-${VER}/hardware/avr/boards.txt <<-EOF
##############################################################

modOsc.name=ModifiedOscilator
modOsc.upload.tool=avrdude
modOsc.upload.protocol=arduino

modOsc.bootloader.tool=avrdude
modOsc.bootloader.unlock_bits=0x3F
modOsc.bootloader.lock_bits=0x0F

modOsc.build.board=AVR_PRO
modOsc.build.core=arduino
modOsc.build.variant=eightanaloginputs

## Arduino board (16 MHz external) w/ ATmega328
## -------------------------------------------------
modOsc.menu.cpu.16MHzexternal=ATmega328 (5V, 16 MHz external xtal)

modOsc.menu.cpu.16MHzexternal.upload.maximum_size=30720
modOsc.menu.cpu.16MHzexternal.upload.maximum_data_size=2048
modOsc.menu.cpu.16MHzexternal.upload.speed=57600

modOsc.menu.cpu.16MHzexternal.bootloader.low_fuses=0xFF
modOsc.menu.cpu.16MHzexternal.bootloader.high_fuses=0xDA
modOsc.menu.cpu.16MHzexternal.bootloader.extended_fuses=0x05
modOsc.menu.cpu.16MHzexternal.bootloader.file=atmega/ATmegaBOOT_168_atmega328.hex

modOsc.menu.cpu.16MHzexternal.build.mcu=atmega328p
modOsc.menu.cpu.16MHzexternal.build.f_cpu=16000000L

## Arduino board (8 MHz internal) w/ ATmega328
## -------------------------------------------------
modOsc.menu.cpu.8MHzinternal=ATmega328 (?V, 8 MHz internal osc)

modOsc.menu.cpu.8MHzinternal.upload.maximum_size=30720
modOsc.menu.cpu.8MHzinternal.upload.maximum_data_size=2048
modOsc.menu.cpu.8MHzinternal.upload.speed=57600

modOsc.menu.cpu.8MHzinternal.bootloader.low_fuses=0xE2
modOsc.menu.cpu.8MHzinternal.bootloader.high_fuses=0xDA
modOsc.menu.cpu.8MHzinternal.bootloader.extended_fuses=0x05
modOsc.menu.cpu.8MHzinternal.bootloader.file=atmega/ATmegaBOOT_168_atmega328_8Mhzint.hex

modOsc.menu.cpu.8MHzinternal.build.mcu=atmega328p
modOsc.menu.cpu.8MHzinternal.build.f_cpu=8000000L

## Arduino board (1 MHz internal) w/ ATmega328
## -------------------------------------------------
modOsc.menu.cpu.1MHzInternal=ATmega328 (?V, 1 MHz Internal, No BoD)

modOsc.menu.cpu.1MHzInternal.upload.maximum_size=30720
modOsc.menu.cpu.1MHzInternal.upload.maximum_data_size=2048
modOsc.menu.cpu.1MHzInternal.upload.speed=9600

modOsc.menu.cpu.1MHzInternal.bootloader.low_fuses=0x62
modOsc.menu.cpu.1MHzInternal.bootloader.high_fuses=0xDA
modOsc.menu.cpu.1MHzInternal.bootloader.extended_fuses=0x07
modOsc.menu.cpu.1MHzInternal.bootloader.file=atmega/ATmegaBOOT_168_atmega328_1Mhzint.hex

modOsc.menu.cpu.1MHzInternal.build.mcu=atmega328p
modOsc.menu.cpu.1MHzInternal.build.f_cpu=1000000L

EOF

}

function installESP32Arduino()
{
	wget https://bootstrap.pypa.io/get-pip.py
	sudo python get-pip.py
	sudo pip install pyserial
	mkdir -p ~/Arduino/hardware/espressif
	cd ~/Arduino/hardware/espressif
	git clone https://github.com/espressif/arduino-esp32.git esp32
	cd esp32
	git submodule update --init --recursive
	cd tools
	python2 get.py
}

function nonIntegratedSW()
{
#arduino
	installArduino
#ESP32-arduino:
	installESP32Arduino
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
