#!/usr/bin/env bash

#
# Update
#
# EMU to 7.0.48.0
# Jlink V616J (6.16.10)
#
# Installs:
# arm toolchain: (gcc-arm-none-eabi-4_9-2015q3)
# TI Emulation package: (ti_emupack_setup_7.0.48.0_linux_x86_64.bin
#

SUPPORT_ARCHIVE=http://tinyprod.net/dev-archive
ARM_TOOLS_URL=https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2

TI_EMU=${SUPPORT_ARCHIVE}/ti_emupack_setup_7.0.48.0_linux_x86_64.bin
JLINK_DEB=${SUPPORT_ARCHIVE}/JLink_Linux_V616j_x86_64.deb

if [[ ! -d installs ]] ; then
  mkdir installs
fi
cd installs

echo "*** Downloading ..."
wget -nv -O ti_emupack ${TI_EMU}
wget -nv -O jlink.deb ${JLINK_DEB}

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
echo "*** Upgrading System"
apt-get -y -V dist-upgrade
echo "*** Upgrade complete"

echo "***"
echo "*** See /home/vagrant/installs/README for paths and other install information"
echo "***"
echo "*** ARM tools (msp432) install complete"
