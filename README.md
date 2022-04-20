# BlueSCSI Updater

Allow you to upgrade an existing BlueSCSI that has a USB boot loader or load the USB boot loader on a BlueSCSI.

To use, click on the green Code button above, and "Download Zip"

It's current form is a set of scripts to help you update. We hope to make this entirly self contained and more fool proof in future updates.

Please report issues, bugs, fixes here to make it better!

## Do I have a compatible BlueSCSI?

### Does your BlueSCSI have a USB Bootloader installed?

* You're BlueSCSI was shipped on or after 2022-04-11.
* The LED flashes quickly at startup.
* The LOG.txt VERSION ends in `-USB`

If yours does you can flash updates via Option #1.

If your BlueSCSI does not have a USB bootloader you can install it with an STLink-V2 following option #2.

# Usage

## Mac

Currently homebrew (https://brew.sh) is required due to having the utilities needed notarized. In the future we hope to remove this depencacy. 

Double click `flash-mac.command`

## Win

Install the Maple Drivers in `utils/maple-usb-drivers-win.7z` - run `install_drivers.bat`

**NOTE**: You will likely need to tell windows to use the correct driver by using [Zadig](https://zadig.akeo.ie/) and switching the Maple device to `libusb-win32` if you see the error `Cannot open DFU device 1eaf:0003 found on devnum 9 (LIBUSB_ERROR_NOT_SUPPORTED)`

Double click `flash-win.bat`

## FAQ

### Q: Getting `Error sending completion packet (LIBUSB_ERROR_IO)`

A: On some machines you may get this error, but it can be ignored. The flash was successful.

### Q: My BlueSCSI does not have a USB Bootloader - can I update it?

A: Yes, but you will need an STLink for the initial flashing of the bootloader, after that you can flash via USB.

Follow option #2 to install the USB bootloader and then the BlueSCSI firmware.

### Q: Getting `Cannot open DFU device 1eaf:0003 found on devnum 9 (LIBUSB_ERROR_NOT_SUPPORTED)`

A: You will need to tell windows to use the correct driver by using Zadig and switching the Maple device to libusb. 

# Utilites Used

* STM32duino-bootloader - https://github.com/rogerclarkmelbourne/STM32duino-bootloader
* OpenOCD - https://openocd.org/
* dfu-util - https://dfu-util.sourceforge.io/
* Homebrew (Mac) - https://brew.sh/
