# ubuntu_dev/arm_msp

The arm_msp vagrant box adds the ARM toolchain (GCC,
https://launchpad.net/gcc-arm-embedded), other TI ARM tools, and Code
Composer Studio to the basic and msp430 boxes.

Note, these toolchains are intended for work on the TI MSP432 chipset which is an
ARM Cortex-m4f core with TI MSP peripherals SOC.

* Component versions:

    gcc: 4.9.3
    gdb: 7.8.0


ARM Paths:

    /usr/gcc-arm-none-eabi-4_9-2015q3/bin
    /usr/gcc-arm-none-eabi-4_9-2015q3/share/doc/gcc-arm-none-eabi/man
    /usr/gcc-arm-none-eabi-4_9-2015q3/share/doc/gcc-arm-none-eabi/info

Various TI ARM tools and support files can be found in /opt/ti, /opt/ti-arm,
/opt/ti-emu, and /opt/ti-mspgcc.

A network installer for Code Composer is in /home/vagrant/CCS_web_linux.tar.gz.
Currently it should install CCS 6.1.3.  It is intended to install CCS locally
as /home/vagrant/ti/ccsv6.  Other TI installers are also left in /home/vagrant


arm include files (msp432 and arm):

    /opt/ti/ccsv6/ccs_base/arm/include
    /opt/ti-arm/arm/include


CCS install:
/opt/ti/ccsv6/eclipse/ccs_base/arm
/opt/ti/ccsv6/eclipse/tools/compiler/gcc-arm-none-eabi-4_9-2015q3

TI msp432 support package:
/opt/ti-arm

TI msp432 emulation  package
/opt/ti-emu
