#!/bin/bash

hostIPAddress=$(sudo host ipsec.broadstreet.ca | sed -n "s/.*IPv4 address //p")
endpoint=$(sudo wg show wg0 endpoints | sed -n "s/^.*\s//p" | sed -n "s/:.*$//p")

if [ "$hostIPAddress" == "$endpoint" ]
then
        echo "$hostIPAddress"
        echo "They match!"
        echo "$endpoint"
else
        echo "$hostIPAddress"
        echo "They don't match :("
        echo "$endpoint"

fi
