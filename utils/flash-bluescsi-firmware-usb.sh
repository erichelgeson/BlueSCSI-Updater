#!/bin/bash
cd "$(dirname "$0")"
BIN_FILE=${1:-BlueSCSI-v1.1-OPTICAL_BETA_20220725-STM32F1-USB.bin}
./find-commands.sh || exit $?
echo
echo "Flashing $BIN_FILE via USB"
echo
echo "* Move BOOT1 to 1 (Jumper nearest the RESET button on the BluePill)"
echo "* Connect via USB to the BluePill"
dfu-util -d 0x1eaf:0x003 --download ./${BIN_FILE} --alt 2 -w
echo
echo "* Move BOOT1 back to 0"
echo "* Disconnect USB"
echo "Happy scuzzing!"