#!/bin/bash

IFACE=$1
ACTION=$2

case "${ACTION}" in
    CONNECTED)
				dhclient "${IFACE}"
        ;;
    DISCONNECTED)
				dhclient -r "${IFACE}"
        ;;
esac
