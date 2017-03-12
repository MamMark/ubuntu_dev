#!/usr/bin/env bash

HOME_EXTRA=

#
# FIXME: Update
#
# openocd to release 0.10.0
# build new ti-arm tarball based on ccsv7
# dir structure revisit.  /opt/ti now has /opt/ti/ti-arm etc.
#    ccsv7 in /opt/ti/ccs/ccsv7
# still want driverlib?
# replace with simplelink?
#

#
# this script creates:
#
# openocd tarball
# ti-arm tarball:
#   TI driverlib for the msp432
#   TI msp432 chip support (linux support package, lsp)
#   TI jtag support (ti-emu)
#

OPENOCD_DESTDIR=/tmp/openocd
OPENOCD_VER=0.10.0-dev-00371-g81631e4
OPENOCD_TARBALL=openocd-${OPENOCD_VER}.tgz
TI_ARM_TARBALL=msp432-ti-arm-`date +%Y-%m-%d`.tgz

echo "***"
echo "*** creating OpenOCD tarball: openocd-${OPENOCD_VER}.tgz"
tar czf ${OPENOCD_TARBALL} -C${OPENOCD_DESTDIR} usr

DRIVERLIB_ROOT=${HOME}${HOME_EXTRA}/mm/Others/msp432_driverlib_3_21_00_05
DRIVERLIB_DIRS="driverlib examples rom"

if [ ! -d ${HOME}/ti/ccsv6/ccs_base/arm/include ] ; then
    echo "CCSv6 must be installed in ~/ti to build ti-arm"
    exit 1
fi

echo "***"
echo "*** creating ti-arm tarball: ${TI_ARM_TARBALL}"
if [ ! -d ti-arm ] ; then
    mkdir ti-arm
fi

# copy TI base msp432 arm files over, msp432 device support.
tar cf - -C ${HOME}/ti/ccsv6/ccs_base arm | tar xf - -C ti-arm

# put a driverlib tree at the ti-arm root as well
tar cf - -C ${DRIVERLIB_ROOT} ${DRIVERLIB_DIRS} | tar xf - -C ti-arm

# fix permissions
find ti-arm -type f -exec chmod -x \{\} \;
find ti-arm -type d -exec chmod +x \{\} \;

# now create the archive.
tar czf ${TI_ARM_TARBALL} ti-arm
/bin/rm -rf ti-arm
