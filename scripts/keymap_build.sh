#!/bin/bash
# vim: set expandtab ts=4 sw=4 tw=0 :

if [ ! -d scripts ]; then
    echo "Run this script from the root project directory"
    exit 1
fi


echo "Note: Keymaps for Lynx, Helios, and Celeste have been moved to the legacy branch."


echo -n "Building Selene keymaps.."
keymap -c keymap_drawer.config.yaml parse -z config/selene.keymap >assets/selene.yaml
keymap -c keymap_drawer.config.yaml draw -d boards/shields/selene/selene-layout.dtsi assets/selene.yaml >assets/selene.svg
echo " Done"
