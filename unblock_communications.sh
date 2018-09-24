#!/bin/bash
set -e
echo "Please wait 5 seconds. Are you sure you cannot avoid sending messages?"
sleep 5
echo "Are you sure? (y/n)"
sleep 30
echo "Ok, here we go"
sudo sed -i -r '/BLOCKME/s/^/# /g' /etc/hosts
