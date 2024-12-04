#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

# NOTE: this will only works when run under the devcontainer
# go to workspace dir, if missing that means its not container
cd "$WORKSPACE_DIR"/app || exit 1

echo -e "${RED}---> Cleaning old build files..${NC}"
rm -rf "$WORKSPACE_DIR"/../zmk-config/builds/*.uf2

echo -e "${RED}---> Building lynx left side..${NC}"
west build -p -d build/lynx_left -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="lynx_left nice_view_adapter nice_view" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building lynx right side..${NC}"
west build -p -d build/lynx_right -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="lynx_right nice_view_adapter nice_view" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building calypso left side..${NC}"
west build -p -d build/calypso_left -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="calypso_left" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building calypso right side..${NC}"
west build -p -d build/calypso_right -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="calypso_right" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building eros left side..${NC}"
west build -p -d build/eros_left -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="eros_left nice_view_adapter nice_view" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building eros right side..${NC}"
west build -p -d build/eros_right -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="eros_right nice_view_adapter nice_view" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building helios..${NC}"
west build -p -d build/helios -b blackpill_f411ce -S studio-rpc-usb-uart -- -DSHIELD="helios" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building keychron..${NC}"
# west build -p -d build/helios -b keychron_q8 -S studio-rpc-usb-uart -- -DSHIELD="helios" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config
west build -p -d build/keychron -b keychron_q8 -S studio-rpc-usb-uart -- -DZMK_EXTRA_MODULES="$WORKSPACE_DIR/../zmk-config;$WORKSPACE_DIR/../zmk-tri-state;$WORKSPACE_DIR/../zmk-num-word;$WORKSPACE_DIR/../zmk-ckled2001" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo -e "${RED}---> Building nice_nano_v2 reset firmware..${NC}"
west build -p -d build/reset -b nice_nano_v2 -- -DSHIELD="settings_reset"

echo -e "${RED}---> Copying and renaming the build..${NC}"
sleep 2
cp build/calypso_left/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/calypso_left.uf2
cp build/calypso_right/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/calypso_right.uf2
cp build/eros_left/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/eros_left.uf2
cp build/eros_right/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/eros_right.uf2
cp build/lynx_left/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/lynx_left.uf2
cp build/lynx_right/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/lynx_right.uf2
cp build/reset/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/nice_nano_v2_reset.uf2

cp build/helios/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/helios.uf2
cp build/keychron/zephyr/zmk.bin "$WORKSPACE_DIR"/../zmk-config/builds/keychron.bin
