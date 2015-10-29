#!/usr/bin/env bash

echo "*** Installing mspgcc-4.6"
wget -qO - http://tinyprod.net/repos/debian/tinyprod.key | apt-key add -
echo "deb http://tinyprod.net/repos/debian wheezy main" >> /etc/apt/sources.list.d/tinyprod-debian.list
echo "deb http://tinyprod.net/repos/debian msp430-46 main" >> /etc/apt/sources.list.d/tinyprod-debian.list

echo "*** Upgrading System"
apt-get update
apt-get -y -V dist-upgrade
echo "*** Upgrade complete"

apt-get install -y -V msp430-46 mspdebug linux-image-extra-virtual

echo "*** msp430-46 tools install complete"
