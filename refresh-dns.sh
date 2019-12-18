#!/bin/bash

set -e
shopt -s nocasematch
shopt -s extglob
export LC_ALL=C

PUBLIC_KEY="YQFBWrpLk49iKjhCAPOJkHlPI+iJFbn1XK87Boz+UEI="
ENDPOINT="test.test:51820"

[[ $(wg show "wg0" latest-handshakes) =~ ${PUBLIC_KEY//+/\\+}\  ([0-9]+) ]] || exit 0
(( ($(date +%s) - ${BASH_REMATCH[1]}) > 135 )) || exit 0
wg set "wg0" peer "$PUBLIC_KEY" endpoint "$ENDPOINT"
