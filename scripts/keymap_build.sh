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

echo -n "Building Celeste keymaps.."
keymap -c keymap_drawer.config.yaml parse -z config/celeste.keymap >assets/celeste.yaml
keymap -c keymap_drawer.config.yaml draw --dts-layout ./boards/arm/celeste/celeste-layout.dtsi assets/celeste.yaml >assets/celeste.svg
echo "Done"

echo -n "Building Selene keymaps.."
keymap -c keymap_drawer.config.yaml parse -z config/selene.keymap >assets/selene.yaml
keymap -c keymap_drawer.config.yaml draw -d boards/shields/selene/selene-layout.dtsi assets/selene.yaml >assets/selene.svg
echo " Done"
