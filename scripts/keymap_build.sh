#!/bin/bash

if [ ! -d scripts ]; then
	echo "Run this script from the root project directory"
	exit 1
fi

echo -n "Building Lynx keymaps.."
keymap -c keymap_drawer.config.yaml parse -c 10 -z config/lynx.keymap >assets/lynx.yaml
keymap -c keymap_drawer.config.yaml draw -k ferris/sweep assets/lynx.yaml >assets/lynx.svg
echo " Done"

echo -n "Building Calypso keymaps.."
keymap -c keymap_drawer.config.yaml parse -c 10 -z config/calypso.keymap >assets/calypso.yaml
keymap -c keymap_drawer.config.yaml draw -k corne_rotated -l LAYOUT_split_3x5_3 assets/calypso.yaml >assets/calypso.svg
echo " Done"
