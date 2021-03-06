#!/bin/bash

hostIPAddress=$(sudo host ipsec.broadstreet.ca | sed -n "s/.*IPv4 address //p")
endpoint=$(sudo wg show wg0 endpoints | sed -n "s/^.*\s//p" | sed -n "s/:.*$//p")
PUBLIC_KEY=JKq/jZVbUho/FOfzg6tKESiNpBQ6B0NvXeuLQSJn0To=
ENDPOINT=ipsec.broadstreet.ca:51820


if [ "$hostIPAddress" == "$endpoint" ]
then
        echo "DNS: $hostIPAddress"
        echo "Endpoint: $endpoint"
else
        echo "DNS: $hostIPAddress"
        echo "Endpoint: $endpoint"
        echo "Rebuilding VPN"
        sudo wg set "wg0" peer "$PUBLIC_KEY" endpoint "$ENDPOINT"
fi
