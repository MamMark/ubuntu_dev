#!/usr/bin/env bash

#
# Installs:
# arm tools: (gcc-arm-none-eabi-4_9-2015q3)
# CCS (code composer): CCS6.1.3.00034_linux.tar.gz superseeded by network install.
# TI GCC support package for 432 procs: (msp432-gcc-1.0.0.1-linux-support-package-installer.run)
# TI Emulation package: (ti_emupack_setup_6.0.407.3_linux_i386.bin)
#

#CCS_VERSION=6.1.3.00034

ARM_TOOLS_URL=https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2

echo "***"
echo "*** Downloading ARM toolchain"
wget -nv -O gcc-arm-none-eabi.tar.bz2 $ARM_TOOLS_URL

echo "*** Installing ARM toolchain"
(cd /usr; tar xf /home/vagrant/gcc-arm-none-eabi.tar.bz2)

echo "*** Downloading TI ARM packages"
wget -nv -O msp432-gcc-support http://tinyprod.net/dev-archive/msp432-gcc-1.0.0.1-linux-support-package-installer.run
wget -nv -O ti_emupack http://tinyprod.net/dev-archive/ti_emupack_setup_6.0.407.3_linux_i386.bin

echo "*** Installing msp432 gcc support files"
chmod +x msp432-gcc-support ti_emupack
./msp432-gcc-support --mode unattended --prefix /opt/ti-arm

echo "***"
echo "*** Downloading Code Compactor Net Install"
wget -nv http://tinyprod.net/dev-archive/CCS_web_linux.tar.gz


echo "*** Installing Emu Pack"
./ti_emupack --mode unattended --prefix /opt/ti-emu

# package upgrade happens in other provisioning script which runs
# after this one.  So don't do this twice.
# mspdebug gets installed with the mspgcc46 tools
# 
# echo "*** Upgrading System"
# apt-get update
# apt-get -y -V dist-upgrade
# echo "*** Upgrade complete"
# apt-get install -y -V mspdebug linux-image-extra-virtual

echo "***"
echo "*** ARM Path: /usr/gcc-arm-none-eabi-4_9-2015q3"
echo "***"
echo "*** ARM tools (msp432) install complete"
