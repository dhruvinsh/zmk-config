#!/bin/bash
# vim: set expandtab ts=4 sw=4 tw=0 :

if [ ! -d scripts ]; then
    echo "Run this script from the root project directory"
    exit 1
fi

echo -n "Building Lynx keymaps.."
keymap -c keymap_drawer.config.yaml parse -c 10 -z config/lynx.keymap >assets/lynx.yaml
keymap -c keymap_drawer.config.yaml draw -k ferris_rotated -l LAYOUT_split_3x5_2 assets/lynx.yaml >assets/lynx.svg
echo " Done"

echo -n "Building Helios keymaps.."
keymap -c keymap_drawer.config.yaml parse -z config/helios.keymap >assets/helios.yaml
keymap -c keymap_drawer.config.yaml draw -k kinesis/stapelberg -l LAYOUT assets/helios.yaml >assets/helios.svg
echo " Done"

echo -n "Building Keychron keymaps.."
keymap -c keymap_drawer.config.yaml parse -z config/keychron_q8.keymap >assets/keychron.yaml
keymap -c keymap_drawer.config.yaml draw --dts-layout ./boards/arm/keychron_q8/keychron-layout.dtsi assets/keychron.yaml >assets/keychron.svg
echo " Done"
