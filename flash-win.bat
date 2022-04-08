@echo off

type utils\banner.txt

set /p choice=Choice?

IF "%choice%"=="1" CALL utils\flash-bluescsi-firmware-usb.bat
IF "%choice%"=="2" CALL utils\flash-usb-bootloader.bat
IF "%choice%"=="H" CALL type utils\help.txt
IF "%choice%"=="P" CALL type utils\sysop.txt
IF "%choice%"=="Q" echo "Goodbye!"

pause