#!/bin/bash

hostIPAddress=$(sudo host test.test | sed -n "s/.*IPv4 address //p")
endpoint=$(sudo wg show wg0 endpoints | sed -n "s/^.*\s//p" | sed -n "s/:.*$//p")

if [ "$hostIPAddress" == "$endpoint" ]
then
        echo "DNS: $hostIPAddress"
        echo "Endpoint: $endpoint"
else
        echo "DNS: $hostIPAddress"
        echo "Endpoint: $endpoint"
        echo "Rebuilding VPN"
        wg set "wg0" peer "$PUBLIC_KEY" endpoint "$ENDPOINT"
fi
