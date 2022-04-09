echo Flashing the generic_boot20_pc13.bin
echo * Move BOOT1 to 1 (Jumper furthest from the RESET button on the BluePill)
echo * Connect the ST-LinkV2 to your BlueSCSI and connect it to your computer.
pause

echo Starting flash...
echo NOTE: Some BulePills can take up to 2 minutes to flash.

utils\openocd\xpack-openocd-0.11.0-4-win-x64\bin\openocd.exe -c "set CPUTAPID 0" -f interface/stlink.cfg -f target/stm32f1x.cfg -c "transport select hla_swd" -c "program utils\\generic_boot20_pc13.bin 0x08000000 verify reset exit"

echo Check output if successful (Windows...)
echo Move the BOOT1 Jumper back to position 0 and disconnect the BlueSCSI
echo Ready to flash BlueSCSI firmware.
pause
call utils\flash-bluescsi-firmware-usb.bat
