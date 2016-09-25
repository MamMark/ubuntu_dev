#!/usr/bin/env bash

#
# Installs:
# arm toolchain: (gcc-arm-none-eabi-4_9-2015q3)
# CCS (code composer): web installer
# TI GCC support package for 432 procs: (msp432-gcc-1.0.0.1-linux-support-package-installer.run)
#    this is old, replace from current CCS.  We create an archive using arm_create_ti_arm.
# TI Emulation package: (ti_emupack_setup_6.0.407.3_linux_i386.bin)
#

SUPPORT_ARCHIVE=http://tinyprod.net/dev-archive
ARM_TOOLS_URL=https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2

TI_ARM=${SUPPORT_ARCHIVE}/msp432-ti-arm-2016-09-25.tgz
TI_LSP=${SUPPORT_ARCHIVE}/msp432-gcc-1.0.0.1-linux-support-package-installer.run
TI_EMU=${SUPPORT_ARCHIVE}/ti_emupack_setup_6.0.407.3_linux_i386.bin
JLINK_DEB=${SUPPORT_ARCHIVE}/JLink_Linux_V610a_x86_64.deb
MSP_FLASHER=${SUPPORT_ARCHIVE}/flasher_1_3_10.tgz
OPENOCD_TARBALL=${SUPPORT_ARCHIVE}/openocd-0.10.0-dev-00371-g81631e4.tgz

if [[ ! -d installs ]] ; then
  mkdir installs
fi
cd installs
echo "***"
echo "*** Downloading ARM toolchain"
wget -nv -O gcc-arm-none-eabi.tar.bz2 $ARM_TOOLS_URL

echo "*** Downloading ..."
wget -nv -O msp432-ti-arm.tgz ${TI_ARM}
wget -nv -O msp432-gcc-lsp ${TI_LSP}
wget -nv -O ti_emupack ${TI_EMU}
wget -nv -O jlink.deb ${JLINK_DEB}
wget -nv -O flasher.tgz ${MSP_FLASHER}
wget -nv -O openocd.tgz ${OPENOCD_TARBALL}

echo "*** Installing ARM toolchain"
tar xf /home/vagrant/installs/gcc-arm-none-eabi.tar.bz2 -C /usr

echo "*** Installing msp432 gcc support files"
chmod +x msp432-gcc-lsp ti_emupack
./msp432-gcc-lsp --mode unattended --prefix /opt/ti-arm-lsp
./ti_emupack --mode unattended --prefix /opt/ti-emu
tar xf msp432-ti-arm.tgz -C /opt

echo "***"
echo "*** Downloading Code Compactor Net Install"
wget -nv http://tinyprod.net/dev-archive/CCS_web_linux.tar.gz

chown -R vagrant:vagrant .

echo "***"
echo "*** Installing JLink (Segger)"
dpkg -i jlink.deb

echo "***"
echo "*** Installing MSPFlasher"

SRC_DIR=MSPFlasher_32_1_3_10
mkdir install
(cd install; tar xf ../flasher.tgz)
SRC_DIR=/home/vagrant/installs/install/${SRC_DIR}

echo "***"
echo "*** installing Flasher and libmsp430.so into /usr/local"
install -v ${SRC_DIR}/libmsp430.so  /usr/local/lib
install -v ${SRC_DIR}/MSP430Flasher /usr/local/bin
echo "*** updating ldconfig library cache"
ldconfig
/bin/rm -rf install

echo "***"
echo "*** Installing OpenOCD, libhidapi, libusb"

#
# openocd needs libhidapi-dev and libusb-1.0-0
#
apt-get install -y libhidapi-dev libusb-1.0-0 libusb-1.0-0-dev
tar xf openocd.tgz -C /

echo "***"
echo "*** Upgrading System"
apt-get update
apt-get -y -V dist-upgrade
echo "*** Upgrade complete"
apt-get install -y -V mspdebug linux-image-extra-virtual

echo "***"
echo "*** See /home/vagrant/installs/README for paths and other install information"
echo "***"
echo "*** ARM tools (msp432) install complete"
