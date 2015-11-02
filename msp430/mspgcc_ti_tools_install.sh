#!/usr/bin/env bash

#TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/3_02_02_00/exports/msp430-gcc-full-linux-installer-3.2.2.0.run
TI_MSPGCC_URL=http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/3_05_00_00/exports/msp430-gcc-full-linux-installer-3.5.0.0.run
TI_MSPGCC_DIR=/opt/ti-mspgcc

echo "***"
echo "*** Downloading TI MSPGCC tools"
wget -nv -O installer $TI_MSPGCC_URL

echo "*** Installing TI MSPGCC"
chmod +x installer
./installer --mode unattended --prefix $TI_MSPGCC_DIR
# Copy headers and ldscripts to the correct location to prevent the need to explicitly include them
cp $TI_MSPGCC_DIR/{include/*.h,msp430-elf/include}
cp $TI_MSPGCC_DIR/{include/*.ld,msp430-elf/lib}

echo "export PATH=$TI_MSPGCC_DIR/bin:$PATH" >> /etc/profile
$TI_MSPGCC_DIR/install_scripts/msp430uif_install.sh

ln -s $TI_MSPGCC_DIR/bin/libmsp430.so /usr/lib/
/bin/rm -rf installer

# package upgrade happens in other provisioning script which runs
# after this one.  So don't do this twice.
# 
# echo "*** Upgrading System"
# apt-get update
# apt-get -y -V dist-upgrade
# echo "*** Upgrade complete"
# apt-get install -y -V mspdebug linux-image-extra-virtual

echo "***"
echo "*** TI tools (msp430) install complete"
