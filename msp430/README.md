# ubuntu_dev/msp430

The msp430 vagrant box adds various TI and other msp430 toolchains to the
basic box to support development on TI msp430 chipsets.

The TI toolchain for the msp430 is the new Redhat version.  It is version
4.0.1.0 (see ../Toolchain_Notes.msp430).

  * Component versions:
    - GCC 5.3.0.105
    - GDB 7.7
    - binutils 2.25
    - Newlib 2.2.0
    - MSPDebugStack 3.7.0.12
    - MSP430 GDB Agent 6.0.14.5

This toolchain is installed in /opt/ti-mspgcc.

PATHS:
    /opt/ti-mspgcc/bin
    /opt/ti-mspgcc/include
    /opt/ti-mspgcc/man


The working toolchain comes from the older TinyProd toolchain.  This toolchain is
installed via debian archives so gets installed in reasonable places.

    msp430-gcc: 4.6.3
    msp430-gdb: 7.2

PATHS:
    /usr/bin            (msp430-gcc, msp430-gdb, msp430-*)
    /usr/share/man
    /usr/share/info
