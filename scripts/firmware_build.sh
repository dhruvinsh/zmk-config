#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

# Display usage information
function usage {
  echo "Usage: $0 [selene|selene_dongle|selene_left|selene_right|xiao_reset]"
  echo
  echo "Build ZMK firmware for Selene keyboard only."
  echo
  echo "Options:"
  echo "  selene           Build all Selene sides (dongle, left, right)"
  echo "  selene_dongle    Build only Selene dongle side"
  echo "  selene_left      Build only Selene left side"
  echo "  selene_right     Build only Selene right side"
  echo "  xiao_reset       Build Seeeduino XIAO BLE reset firmware"
  echo "  -h, --help       Display this help message"
  echo
  echo "All other keyboard configs have been moved to the legacy branch."
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

# Function to build selene dongle
function build_selene_dongle {
  echo -e "${RED}---> Building selene dongle side..${NC}"
  west build -p -d build/selene_dongle -b seeeduino_xiao_ble -S studio-rpc-usb-uart -- -DSHIELD="selene_dongle prospector_adapter" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-modules/zmk-tri-state;$WORKSPACE_DIR/../zmk-modules/zmk-num-word;$WORKSPACE_DIR/../zmk-modules/zmk-rgbled-widget;$WORKSPACE_DIR/../zmk-modules/prospector-zmk-module" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
  cp build/selene_dongle/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/selene_dongle.uf2
}

# Function to build selene left
function build_selene_left {
  echo -e "${RED}---> Building selene left side..${NC}"
  west build -p -d build/selene_left -b seeeduino_xiao_ble -S studio-rpc-usb-uart -- -DSHIELD="selene_left rgbled_adapter" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-modules/zmk-tri-state;$WORKSPACE_DIR/../zmk-modules/zmk-num-word;$WORKSPACE_DIR/../zmk-modules/zmk-rgbled-widget" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
  cp build/selene_left/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/selene_left.uf2
}

# Function to build selene right
function build_selene_right {
  echo -e "${RED}---> Building selene right side..${NC}"
  west build -p -d build/selene_right -b seeeduino_xiao_ble -S studio-rpc-usb-uart -- -DSHIELD="selene_right rgbled_adapter" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-modules/zmk-tri-state;$WORKSPACE_DIR/../zmk-modules/zmk-num-word;$WORKSPACE_DIR/../zmk-modules/zmk-rgbled-widget" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
  cp build/selene_right/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/selene_right.uf2
}

# Function to build reset firmware
function build_xiao_reset {
  echo -e "${RED}---> Building xiao ble reset firmware..${NC}"
  west build -p -d build/xiao_reset -b seeeduino_xiao_ble -- -DSHIELD="settings_reset"
  cp build/xiao_reset/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/xiao_reset.uf2
}

# Create builds directory if it doesn't exist
mkdir -p "$WORKSPACE_DIR"/../zmk-config/builds

# If no arguments provided, build all selene sides
if [ $# -eq 0 ]; then
  clean_builds
  build_selene_dongle
  build_selene_left
  build_selene_right
  build_xiao_reset
  exit 0
fi

# Process arguments
for arg in "$@"; do
  case "$arg" in
  "selene")
    build_selene_dongle
    build_selene_left
    build_selene_right
    build_xiao_reset
    ;;
  "selene_dongle")
    build_selene_dongle
    ;;
  "selene_left")
    build_selene_left
    ;;
  "selene_right")
    build_selene_right
    ;;
  "xiao_reset")
    build_xiao_reset
    ;;
  *)
    echo "Unknown keyboard or missing Selene config: $arg"
    echo "All other keyboard configs have been moved to the legacy branch."
    usage
    ;;
  esac
done

echo -e "${RED}---> Build completed successfully${NC}"
