#!/usr/bin/env bash
# UniFi Security Gateways and EdgeOS Package Updater
# This script checks /config/data/install-packages/ for downloaded
# packages and installs any that aren't installed
# 
# Author: Neil Beadle
# Modifications by Kolby:
# Added lines to download the latest wireguard for ER release
# Added reboot if a package gets installed

downloads=/config/data/install-packages
scripts=/config/scripts

cd $scripts
curl -O https://raw.githubusercontent.com/BSPDevelopers/edgeos-resources/master/refresh-dns.sh > refresh-dns.sh

cd $downloads
curl -LJO https://github.com/BSPDevelopers/edgeos-resources/raw/master/wireguard-v2.0-e50.deb > wireguard.deb

for pkg in *; do
  dpkg-query -W --showformat='${Status}\n' $(dpkg --info "${pkg}" | grep "Package: " | awk -F' ' '{ print $NF}') > /dev/null 2>&1 || (dpkg -i ${pkg} && reboot now)
done

cd -
