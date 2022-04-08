#!/bin/bash
clear
cd "$(dirname "$0")"

if [ -z $1 ]; then # If you're not fun just pass something as $1
    echo -n "Dialing 1-800-BLUESCSI"
    echo -n .; sleep 1; echo -n .; sleep 1; echo -n .; sleep 1; echo -n .; sleep 1
    echo "Connected!"; sleep 1
fi
cat utils/banner.txt
while true; do
    read -p "Choice? " yn
    case $yn in
        [1]* ) ./utils/flash-bluescsi-firmware-usb.sh; break;;
        [2]* ) ./utils/flash-usb-bootloader.sh; break;;
        [?hH]* ) cat utils/help.txt; read; cat utils/banner.txt;;
        [pP]* ) cat utils/sysop.txt ;;
        [dD]* ) echo "secret debug menu";;
        [qQ]* ) echo "Goodbye!"; exit;;
        * ) echo "Please choose a valid option.";;
    esac
done