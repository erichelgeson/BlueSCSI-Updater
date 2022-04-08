
# determine the best utils to use
# eg, darwin
PLATFORM=$(uname)

if [ $PLATFORM == "Darwin" ]; then
    if command -v brew &> /dev/null; then
        if  ! command -v openocd &> /dev/null then
            echo "Found homebrew, installing openocd"
            brew install openocd dfu-util
        fi
        if ! command -v dfu-util &> /dev/null;
            echo "Found homebrew, installing dfu-util"
        fi
    else
        echo "Homebrew is currently required for MacOS to install the signed utilities we need to flash."
        echo "Please follow the instructions at https://brew.sh/ and re-run this script"
        exit
    fi
fi

if ! command -v openocd &> /dev/null; then
    echo "Please install openocd from your platforms repository."
    exit
fi

if ! command -v dfu-util &> /dev/null; then
    echo "Please install dfu-util from your platforms repository."
    exit
fi