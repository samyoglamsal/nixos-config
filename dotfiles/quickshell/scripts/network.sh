#!/usr/bin/env bash
# Prints "none", "wifi <signal %>", or "eth <ip/cidr>" for the default-route interface.
iface=$(ip route show default | awk '{print $5; exit}')

if [ -z "$iface" ]; then
    echo none
elif [ -d "/sys/class/net/$iface/wireless" ]; then
    sig=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | awk -F: '$1 == "yes" {print $2; exit}')
    echo "wifi ${sig:-0}"
else
    addr=$(ip -4 -o addr show dev "$iface" | awk '{print $4; exit}')
    echo "eth ${addr:-noip}"
fi
