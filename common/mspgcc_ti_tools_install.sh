#!/usr/bin/env bash

#TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/3_02_02_00/exports/msp430-gcc-full-linux-installer-3.2.2.0.run
#TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/3_05_00_00/exports/msp430-gcc-full-linux-installer-3.5.0.0.run
TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/4_00_01_00/exports/msp430-gcc-full-linux-installer-4.0.1.0.run
TI_MSPGCC_DIR=/opt/ti-mspgcc

echo "***"
echo "*** Downloading TI MSPGCC tools"
wget -nv -O installer $TI_MSPGCC_URL

echo "*** Installing TI MSPGCC into ${TI_MSPGCC_DIR}"
chmod +x installer
./installer --mode unattended --prefix $TI_MSPGCC_DIR

# Copy headers and ldscripts to the correct location to prevent the need to explicitly include them
cp $TI_MSPGCC_DIR/{include/*.h,msp430-elf/include}
cp $TI_MSPGCC_DIR/{include/*.ld,msp430-elf/lib}

echo "export PATH=$TI_MSPGCC_DIR/bin:$PATH" >> /etc/profile
$TI_MSPGCC_DIR/install_scripts/msp430uif_install.sh

# don't move libmsp430.so.  happens later with Flasher
# ln -s $TI_MSPGCC_DIR/bin/libmsp430.so /usr/lib/

/bin/rm -rf installer

# package upgrade happens in other provisioning script which runs
# after this one.  So don't do this twice.
# mspdebug gets installed with the mspgcc46 tools
# 
# echo "*** Upgrading System"
# apt-get update
# apt-get -y -V dist-upgrade
# echo "*** Upgrade complete"
# apt-get install -y -V mspdebug linux-image-extra-virtual

# 1.3.10 is 32 bit only but it works fine on 64 bit machines

#if [ $(uname -m) == 'x86_64' ] ; then
#  SRC_DIR=MSPFlasher_64_1.3.8
#else
#  SRC_DIR=MSPFlasher_32_1.3.8
#fi

SRC_DIR=MSPFlasher_32_1_3_10
mkdir install
(cd install; tar xf ../flasher.tgz)
SRC_DIR=/home/vagrant/install/${SRC_DIR}

echo "***"
echo "*** installing Flasher and libmsp430.so into /usr/local"
install -v ${SRC_DIR}/libmsp430.so  /usr/local/lib
install -v ${SRC_DIR}/MSP430Flasher /usr/local/bin
echo "*** updating ldconfig library cache"
ldconfig
/bin/rm -rf install flasher.tgz

echo "***"
echo "*** TI tools (msp430) install complete"
