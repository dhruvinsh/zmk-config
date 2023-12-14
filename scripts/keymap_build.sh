#!/bin/bash

if [ ! -d scripts ]; then
	echo "Run this script from the root project directory"
	exit 1
fi

echo -n "Building keymaps.."
pipenv run keymap -c keymap_drawer.config.yaml parse -c 10 -z config/boards/shields/lynx/lynx.keymap >assets/lynx.yaml
pipenv run keymap -c keymap_drawer.config.yaml draw --qmk-keyboard ferris/sweep assets/lynx.yaml >assets/lynx.svg
echo " Done"
