#!/bin/bash
# vim: set expandtab ts=4 sw=4 tw=0 :

if [ ! -d scripts ]; then
    echo "Run this script from the root project directory"
    exit 1
fi

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
keymap -c keymap_drawer.config.yaml draw --dts-layout ./boards/arm/keychron_q8/keychron-layout.dtsi assets/keychron.yaml >assets/keychron.svg
echo " Done"
