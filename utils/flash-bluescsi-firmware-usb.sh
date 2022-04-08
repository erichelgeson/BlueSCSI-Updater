#!/bin/bash
cd "$(dirname "$0")"
BIN_FILE=${1:-BlueSCSI-v1.1-20220404-USB.bin}
./find-commands.sh
echo
echo "Flashing $BIN_FILE via USB"
echo
echo "* Move BOOT0 to 1 (Jumper nearest the RESET button on the BluePill)"
dfu-util -d 0x1eaf:0x003 --download ./${BIN_FILE} --alt 2 -w
echo
echo "Move BOOT0 back to 0"
echo "Dissconnect USB"
echo "Happy scuzzing!"