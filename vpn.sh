#!/bin/sh

IFACE=$(ip -o link show | awk -F': ' '/tun0/ {print $2}')

if [ "$IFACE" = "tun0" ]; then
  echo "$(ip a show tun0 | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+')"
else
  echo ""
fi
