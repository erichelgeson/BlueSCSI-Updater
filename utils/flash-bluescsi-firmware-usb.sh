#!/bin/bash
cd "$(dirname "$0")"
BIN_FILE=${1:-BlueSCSI-v1.1-20220404-USB.bin}
./find-commands.sh
echo
echo "Flashing $BIN_FILE via USB"
echo
echo "* Move BOOT0 to 1 (Jumper nearest the RESET button on the BluePill)"
echo "* Connect via USB to the BluePill"
echo "Once the PC13 LED is flashing quickly it's ready to be flashed."
echo "Press return to continue..."
read
dfu-util -d 0x1eaf:0x003 --download ./${BIN_FILE} --alt 2
if [ $? -eq 74 ]; then
    echo
    echo "ERROR: ** No BlueSCSI found or jumpers not set correctly **"
    echo "Please dial back in and try again."
    exit 74
fi
echo "Move BOOT0 back to 0"
echo "Dissconnect USB"
echo "Happy scuzzing!"