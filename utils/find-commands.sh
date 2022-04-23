
# determine the best utils to use
# eg, darwin
PLATFORM=$(uname)

if [ $PLATFORM == "Darwin" ]; then
    if command -v brew &> /dev/null; then
        if  ! command -v openocd &> /dev/null; then
            echo "Found homebrew, installing openocd"
            # https://github.com/libusb/libusb/issues/928
            # Remove --HEAD on next openocd release
            brew update && brew install openocd --HEAD
            if [ $? -ne 0 ]; then
                echo "Failed to install openocd. Review logs for error. If the issue perrsists please file an issue."
                exit 1
            fi
        fi
        if ! command -v dfu-util &> /dev/null; then
            echo "Found homebrew, installing dfu-util"
            brew update && brew install dfu-util
            if [ $? -ne 0 ]; then
                echo "Failed to install dfu-util. Review logs for error. If the issue perrsists please file an issue."
                exit 1
            fi
        fi
    else
        echo "Homebrew is currently required for MacOS to install the signed utilities we need to flash."
        echo "Please follow the instructions at https://brew.sh/ and re-run this script"
        exit 1
    fi
fi

if ! command -v openocd &> /dev/null; then
    echo "Please install openocd from your platforms repository."
    exit 1
fi

if ! command -v dfu-util &> /dev/null; then
    echo "Please install dfu-util from your platforms repository."
    exit
fi