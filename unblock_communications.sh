#!/bin/bash
set -e
echo "Please wait 5 seconds. Are you sure you cannot avoid checking messages?"
sleep 5
while true; do
    read -p "Are you sure (y/n)? " yn
    case $yn in
        [Yy]* ) break;;
        * ) exit;;
    esac
done

echo "I will block you for 30 seconds"
sleep 30
echo "Ok, here we go"
sudo sed -i -r '/BLOCKME/s/^/# /g' /etc/hosts
