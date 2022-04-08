#!/bin/bash
cd "$(dirname "$0")"
# OpenOCD
# check if homebrew is installed
# else use bins in folders
BIN_FILE=${1:-generic_boot20_pc13.bin}
echo "Flashing the $BIN_FILE"
echo "* Move BOOT1 to 1 (Jumper furthest from the RESET button on the BluePill)"
echo "* Connect the ST-LinkV2 to your BlueSCSI and connect it to your computer."
echo "Press return to continue..."
read

echo "Starting flash..."
echo "NOTE: Some BluePills can take up to 2 minutes to flash."

rm -f output.log
openocd \
    --log_output output-log.txt \
    -c "set CPUTAPID 0" \
    -f interface/stlink.cfg \
    -f target/stm32f1x.cfg \
    -c "transport select hla_swd" \
    -c "program ${BIN_FILE} 0x08000000 verify reset exit" \

OK=$(grep 'Verified OK' output-log.txt -c)
if [[ $OK -eq 1 ]]; then
    echo "USB Bootloader loaded successfully! Ready to flash BlueSCSI firmware."
    echo "Move the BOOT1 Jumper back to position 0 and disconnect the BlueSCSI"
    echo
    echo "Ready to flash BlueSCSI firmware."
    echo "Press any key to continue..." 
    read
    ./flash-bluescsi-firmware-usb.sh
else
    echo "An error occured:"
    cat output-log.txt
fi