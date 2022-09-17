echo Flashing BlueSCSI-v1.1-20220917-STM32F1-USB.bin
echo * Move BOOT1 to 1 (Jumper nearest the RESET button on the BluePill)
echo * Connect via USB to the BluePill
utils\dfu-util\dfu-util-win-x64\dfu-util-static.exe -d 0x1eaf:0x003 --download utils/BlueSCSI-v1.1-20220917-STM32F1-USB.bin --alt 2 -w
echo Check output if successful (Windows...)
echo * Move BOOT1 back to 0
echo * Disconnect USB
echo Happy scuzzing!