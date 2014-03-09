#!/bin/sh

sleep 30 # wait for system boot

sudo mv -f /tmp/sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y install curl
