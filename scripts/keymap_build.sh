#!/bin/bash

# From buid job,
# parse_args: >-
# 	lynx:'-c 10 -z config/lynx.keymap'
# 	calypso:'-c 10 -z config/calypso.keymap'
# 	helios:'-z config/helios.keymap'
# draw_args:
# 	lynx:'-k ferris/sweep -l LAYOUT_split_3x5_2'
# 	calypso:'-k splitkb/aurora/corne -l LAYOUT_split_3x5_3'
# 	helios:'-k kinesis/stapelberg -l LAYOUT'

if [ ! -d scripts ]; then
	echo "Run this script from the root project directory"
	exit 1
fi

echo -n "Building Lynx keymaps.."
keymap -c keymap_drawer.config.yaml parse -c 10 -z config/lynx.keymap >assets/lynx.yaml
keymap -c keymap_drawer.config.yaml draw -k ferris_rotated -l LAYOUT_split_3x5_2 assets/lynx.yaml >assets/lynx.svg
echo " Done"

echo -n "Building Calypso keymaps.."
keymap -c keymap_drawer.config.yaml parse -c 10 -z config/calypso.keymap >assets/calypso.yaml
keymap -c keymap_drawer.config.yaml draw -k corne_rotated -l LAYOUT_split_3x5_3 assets/calypso.yaml >assets/calypso.svg
echo " Done"

echo -n "Building Helios keymaps.."
keymap -c keymap_drawer.config.yaml parse -z config/helios.keymap >assets/helios.yaml
keymap -c keymap_drawer.config.yaml draw -k kinesis/stapelberg -l LAYOUT assets/helios.yaml >assets/helios.svg
echo " Done"

echo -n "Building Keychron keymaps.."
keymap -c keymap_drawer.config.yaml parse -z config/keychron_q8.keymap >assets/keychron.yaml
keymap -c keymap_drawer.config.yaml draw -k keychron/q8/ansi_encoder -l LAYOUT_ansi_69 assets/keychron.yaml >assets/keychron.svg
echo " Done"
