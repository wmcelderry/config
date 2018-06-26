#!/bin/bash

level=$1


val=$((level * 7500 /976 ))
echo ${val}  | sudo tee /sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-eDP-1/intel_backlight/brightness >&/dev/null

