#!/bin/bash

# NOTE: this will only works when run under the devcontainer
# go to workspace dir, if missing that means its not container
cd "$WORKSPACE_DIR"/app || exit 1

echo "---> Building lynx left side.."
west build -d build/lynx_left -b nice_nano_v2 -- -DSHIELD="lynx_left nice_view_adapter nice_view" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR"/../zmk-config

echo "---> Building lynx right side.."
west build -d build/lynx_right -b nice_nano_v2 -- -DSHIELD="lynx_right nice_view_adapter nice_view" -DZMK_EXTRA_MODULES="$WORKSPACE_DIR"/../zmk-config

echo "---> Building calypso left side.."
west build -d build/calypso_left -b nice_nano_v2 -- -DSHIELD="corne_left" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo "---> Building calypso right side.."
west build -d build/calypso_right -b nice_nano_v2 -- -DSHIELD="corne_right" -DZMK_CONFIG="$WORKSPACE_DIR"/../zmk-config/config

echo "---> Building reset firmware.."
west build -d build/reset -b nice_nano_v2 -- -DSHIELD="settings_reset"

echo "---> Copying and renaming the build.."
sleep 2
cp build/lynx_left/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/lynx_left.uf2
cp build/lynx_right/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/lynx_right.uf2
cp build/calypso_left/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/calypso_left.uf2
cp build/calypso_right/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/calypso_right.uf2
cp build/reset/zephyr/zmk.uf2 "$WORKSPACE_DIR"/../zmk-config/builds/reset.uf2
