#!/bin/bash

if [ ! -d build ]; then
	echo "Run this script form the project root"
	exit 1
fi

echo -n "Fixing permissions.."
sudo chown "$USER":"$USER" ./build/*
chmod 644 ./build/*
sleep 1
echo " Done"
