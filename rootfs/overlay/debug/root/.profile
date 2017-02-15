#!/bin/sh

echo -e "\033[1;33m"			# for yellow color

echo -e "\n=========================== HELLO IN BASE ROOTFS ==========================="
echo -e "Quick guide:\n"
echo -e "\n\tWiFi:"
echo -e "\t\t\"wifi_scan\" for WiFi networks scanning"
echo -e "\t\t\"wifi_start -n <SSID> -p <password>\" for WiFi network connect"
echo -e "\n\tAudio:"
echo -e "\t\t\"alsamixer\" for soundcard volume level"
echo -e "\t\t\"aplay /usr/share/sounds/alsa/<file_name>\" for headphone output test"
echo -e "\n\tDisplay:"
echo -e "\t\t\"df_window --dfb:no-vt\" for test display"
echo -e "\n\tOthers:"
echo -e "\t\t\"button\" for test buttons"
echo -e "============================================================================\n"

echo -e "\033[0m"				# for no color
