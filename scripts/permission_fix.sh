#!/bin/bash

if [ ! -d builds ]; then
	echo "Run this script form the project root"
	exit 1
fi

echo -n "Fixing permissions.."
sudo chown "$USER":"$USER" ./builds/*
chmod 644 ./builds/*
sleep 1
echo " Done"
