#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

# Display usage information
function usage {
    echo "Usage: $0 [keyboard_name...]"
    echo
    echo "Build ZMK firmware for custom keyboards"
    echo
    echo "Options:"
    echo "  keyboard_name    Name of keyboard to build (lynx, helios, celeste, reset)"
    echo "                   If no keyboard is specified, all keyboards will be built"
    echo "  -h, --help       Display this help message"
    echo
    echo "Available keyboards:"
    echo "  lynx             Build lynx (left and right sides)"
    echo "  lynx_left        Build only lynx left side"
    echo "  lynx_right       Build only lynx right side"
    echo "  helios           Build helios"
    echo "  celeste          Build celeste"
    echo "  reset            Build nice_nano_v2 reset firmware"
    echo "  all              Build all keyboards (default)"
    exit 1
}

# Check for help argument
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# NOTE: this will only works when run under the devcontainer
# go to workspace dir, if missing that means its not container
cd "$WORKSPACE_DIR"/app || exit 1

# Clean old build files
function clean_builds {
    echo -e "${RED}---> Cleaning old build files..${NC}"
    rm -rf "$WORKSPACE_DIR"/../zmk-config/builds/*.{uf2,bin}
}

# Function to build lynx dongle
function build_lynx_dongle {
    echo -e "${RED}---> Building lynx dongle side..${NC}"
    west build -p -d build/lynx_dongle -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="lynx_dongle" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
    cp build/lynx_dongle/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/lynx_dongle.uf2
}

# Function to build lynx left
function build_lynx_left {
    echo -e "${RED}---> Building lynx left side..${NC}"
    west build -p -d build/lynx_left -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="lynx_left" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
    cp build/lynx_left/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/lynx_left.uf2
}

# Function to build lynx right
function build_lynx_right {
    echo -e "${RED}---> Building lynx right side..${NC}"
    west build -p -d build/lynx_right -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="lynx_right" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
    cp build/lynx_right/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/lynx_right.uf2
}

# Function to build helios
function build_helios {
    echo -e "${RED}---> Building helios..${NC}"
    west build -p -d build/helios -b blackpill_f411ce -S studio-rpc-usb-uart -- -DSHIELD="helios" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
    cp build/helios/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/helios.uf2
}

# Function to build celeste
function build_celeste {
    echo -e "${RED}---> Building celeste..${NC}"
    west build -p -d build/celeste -b celeste -S studio-rpc-usb-uart -- -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word;$WORKSPACE_DIR/../zmk-ckled2001" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
    cp build/celeste/zephyr/zmk.bin "$WORKSPACE_DIR"/../zmk-config/builds/celeste.bin
}

# Function to build reset firmware
function build_reset {
    echo -e "${RED}---> Building nice_nano_v2 reset firmware..${NC}"
    west build -p -d build/reset -b nice_nano_v2 -- -DSHIELD="settings_reset"
    cp build/reset/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/nice_nano_v2_reset.uf2
}

# Create builds directory if it doesn't exist
mkdir -p "$WORKSPACE_DIR"/../zmk-config/builds

# If no arguments provided, build all keyboards
if [ $# -eq 0 ]; then
    clean_builds
    build_lynx_dongle
    build_lynx_left
    build_lynx_right
    build_helios
    build_celeste
    build_reset
    exit 0
fi

# Process arguments
for arg in "$@"; do
    case "$arg" in
    "lynx")
        build_lynx_dongle
        build_lynx_left
        build_lynx_right
        ;;
    "lynx_dongle")
        build_lynx_dongle
        ;;
    "lynx_left")
        build_lynx_left
        ;;
    "lynx_right")
        build_lynx_right
        ;;
    "helios")
        build_helios
        ;;
    "celeste")
        build_celeste
        ;;
    "reset")
        build_reset
        ;;
    "all")
        clean_builds
        build_lynx_left
        build_lynx_right
        build_helios
        build_celeste
        build_reset
        ;;
    *)
        echo "Unknown keyboard: $arg"
        usage
        ;;
    esac
done

echo -e "${RED}---> Build completed successfully${NC}"
