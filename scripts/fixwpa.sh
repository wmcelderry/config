sudo pkill wpa_supplicant
sudo wpa_supplicant -B -i wlp2s0 -Dnl80211 -c/etc/wpa_supplicant/wpa_supplicant.conf
sleep 2
#automatically get an IP when the network changes:
/sbin/wpa_cli -i wlp2s0 -B -a /home/will/scripts/wpa_action.sh

