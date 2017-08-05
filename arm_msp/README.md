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

TI msp432 emulation  package
/opt/ti-emu
