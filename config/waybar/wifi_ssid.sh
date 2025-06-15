#!/bin/bash

SSID=$(sudo wpa_cli -i wlan0 status | grep '^ssid=' | cut -d= -f2)

if [[ -n "$SSID" ]]; then
  echo "{\"text\": \" $SSID\", \"tooltip\": \"Connected to $SSID\"}"
else
  echo "{\"text\": \"睊 offline\", \"tooltip\": \"No Wi-Fi\"}"
fi
