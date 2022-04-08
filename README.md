# BlueSCSI-USB-Flasher

Allow you to upgrade an existing BlueSCSI that has a USB boot loader or load the USB boot loader on a BlueSCSI.

## Do I have a compatible BlueSCSI?

Look at the LOG.txt on your BlueSCSI - if the version ends in `-USB` you can use this utility to flash newer firmwares.

If it does not you can still use this utility to laod the bootloader but it will require a STLink-V2 to do the inital load.

# Usage

## Mac

Double click `flash-mac.command`

## Win

Double click `flash-win.bat`

# Compatible platforms.

This utility should run on:

* Macintosh x86_64
* Macintosh M1 (with homebrew) 

## Coming soon

* Windows x86_64
* Linux x86_64

## Other

If you do not see your platform here you can open a pull request to add it, or just take a look at the commands the scripts run and run them manually.

# Utilites

STM32duino-bootloader - https://github.com/rogerclarkmelbourne/STM32duino-bootloader
OpenOCD - https://openocd.org/
dfu-util - https://dfu-util.sourceforge.io/
Homebrew (Mac) - https://brew.sh/