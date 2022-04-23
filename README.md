# BlueSCSI Updater

Allow you to upgrade an existing BlueSCSI that has a USB boot loader or load the USB boot loader on a BlueSCSI.


It's current form is a set of scripts to help you update. We hope to make this entirly self contained and more fool proof in future updates.

Please report issues, bugs, fixes here to make it better!

# Usage 

## Step 0: Do you have a compatible BlueSCSI?

### Does your BlueSCSI have a USB Bootloader installed?

* You're BlueSCSI was shipped on or after 2022-04-11.
* The LED flashes quickly at startup.
* The LOG.txt VERSION ends in `-USB`

#### Yes to any above?

Great! You can flash updates via **Option #1** in the script.

#### No?

If your BlueSCSI does **not** have a USB bootloader you can install it with with this script with an STLink via **Option #2** in the script

**NOTE:** It is not trivial to setup STLink and flash the bootloader for the first time as the tooling is inteded for developrs. We try to make it as easy as possible but you may run into issues. Please read everything carefully if you choose this route. 

#### Can someone do it for me?

Yes! If you purchased a BlueSCSI before the USB bootloader was installed from an authorized seller we will upgrade it for the cost of shipping.

## Step 1: Download this github repo as a zip

Click on the green **Code** button above, and **"Download Zip"**

Extract it.

## Step 2: 

## Mac

Tested on macOS 12.0 Monterey.

Currently homebrew (https://brew.sh) is required due to having the utilities needed notarized. In the future we hope to remove this depencacy. 

Double click `flash-mac.command`

## Win

Tested on Windows 10.

Install the Maple Drivers in `utils/maple-usb-drivers-win.7z` - run `install_drivers.bat`

Double click `flash-win.bat`

**NOTE**: If you see  `Cannot open DFU device 1eaf:0003 found on devnum 9 (LIBUSB_ERROR_NOT_SUPPORTED)` you may need to tell windows to use the correct driver by using [Zadig](https://zadig.akeo.ie/) and switching the Maple device to `libusb-win32`.

## FAQ

### Q: I'm getting a DFU error and I've tried everything!

A: Make sure your USB cable is not a "Charge Only" cable - data needs to be passed to the BlueSCSI to flash! (You'd be surprsied how many of these cables are out there)

### Q: Getting `Error sending completion packet (LIBUSB_ERROR_IO)`

A: On some machines you may get this error, but it can be ignored. The flash was successful.

### Q: My BlueSCSI does not have a USB Bootloader - can I update it?

A: Yes, but you will need an STLink for the initial flashing of the bootloader, after that you can flash via USB.

Follow option #2 to install the USB bootloader and then the BlueSCSI firmware.

### Q: Getting `Cannot open DFU device 1eaf:0003 found on devnum 9 (LIBUSB_ERROR_NOT_SUPPORTED)`

A: You may need to tell windows to use the correct driver by using [Zadig](https://zadig.akeo.ie/) and switching the Maple device to `libusb-win32`.

# Utilites Used

* STM32duino-bootloader - https://github.com/rogerclarkmelbourne/STM32duino-bootloader
* OpenOCD - https://openocd.org/
* dfu-util - https://dfu-util.sourceforge.io/
* Homebrew (Mac) - https://brew.sh/
