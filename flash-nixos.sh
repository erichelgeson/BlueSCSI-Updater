#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "${1:-}" ]; then
    echo -n "Dialing 1-800-BLUESCSI"
    echo -n .; sleep 1; echo -n .; sleep 1; echo -n .; sleep 1; echo -n .; sleep 1
    echo "Connected!"; sleep 1
fi

cat "$SCRIPT_DIR/utils/banner.txt"

flash_firmware_usb() {
    local bin_file="${1:-BlueSCSI-v1.1-20231116-STM32F1-USB.bin}"
    echo
    echo "Flashing $bin_file via USB"
    echo
    echo "* Move BOOT1 to 1 (Jumper nearest the RESET button on the BluePill)"
    echo "* Connect via USB to the BluePill"

    local log_file
    log_file=$(mktemp)

    if ! dfu-util -d 0x1eaf:0x003 --download "$SCRIPT_DIR/utils/$bin_file" --alt 2 -w 2>"$log_file"; then
        if grep -q 'Cannot open DFU device\|Permission denied\|LIBUSB_ERROR_ACCESS' "$log_file"; then
            echo
            echo "USB permission denied. Please run with sudo:"
            echo "  sudo $0"
            rm -f "$log_file"
            exit 1
        fi
        echo "An error occurred:"
        cat "$log_file"
        rm -f "$log_file"
        exit 1
    fi
    rm -f "$log_file"

    echo
    echo "* Move BOOT1 back to 0"
    echo "* Disconnect USB"
    echo "Happy scuzzing!"
}

flash_bootloader() {
    local bin_file="${1:-generic_boot20_pc13.bin}"
    echo
    echo "Flashing the $bin_file via STLink V2"
    echo "* Move BOOT0 to 1 (Jumper furthest from the RESET button on the BluePill)"
    echo "* Connect the ST-LinkV2 to your BlueSCSI and connect it to your computer."
    echo "Press return to continue..."
    read -r

    echo "Starting flash..."
    echo "NOTE: Some BluePills can take up to 2 minutes to flash."

    local log_file
    log_file=$(mktemp)

    # Run openocd, capturing both stdout and the log file
    openocd \
        --log_output "$log_file" \
        -c "set CPUTAPID 0" \
        -f interface/stlink.cfg \
        -f target/stm32f1x.cfg \
        -c "program $SCRIPT_DIR/utils/$bin_file 0x08000000 verify reset exit" 2>&1 | tee -a "$log_file" || true

    if grep -q 'LIBUSB_ERROR_ACCESS' "$log_file"; then
        echo
        echo "USB permission denied. Please run with sudo:"
        echo "  sudo $0"
        rm -f "$log_file"
        exit 1
    elif grep -q 'Verified OK' "$log_file"; then
        echo
        echo "USB Bootloader loaded successfully! Ready to flash BlueSCSI firmware."
        echo
        echo "* Move the BOOT0 Jumper back to position 0"
        echo "* Disconnect the BlueSCSI from the STLink"
        echo
        echo "Ready to flash BlueSCSI firmware."
        echo "Press any key to continue..."
        read -r
        rm -f "$log_file"
        flash_firmware_usb
    else
        echo "An error occured:"
        cat "$log_file"
        echo "Please dial back in and try again."
        rm -f "$log_file"
        exit 1
    fi
}

while true; do
    read -rp "Choice? " yn
    case $yn in
        [1]* ) flash_firmware_usb; break;;
        [2]* ) flash_bootloader; break;;
        [?hH]* ) cat "$SCRIPT_DIR/utils/help.txt"; read -r; cat "$SCRIPT_DIR/utils/banner.txt";;
        [pP]* ) cat "$SCRIPT_DIR/utils/sysop.txt" ;;
        [dD]* ) echo "secret debug menu";;
        [qQ]* ) echo "Goodbye!"; exit;;
        * ) echo "Please choose a valid option.";;
    esac
done
