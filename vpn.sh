#!/bin/bash

ip_address=$(/bin/cat $HOME/.config/polybar/scripts/target.txt)

if [ -n "$ip_address" ]; then
  echo "$ip_address"
else
  echo ""
fi
[melvin@archlinux scripts]$ cat vpn.sh 
#!/bin/sh

IFACE=$(ip -o link show | awk -F': ' '/tun0/ {print $2}')

if [ "$IFACE" = "tun0" ]; then
  echo "$(ip a show tun0 | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+')"
else
  echo ""
fi
