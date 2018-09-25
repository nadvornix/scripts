#!/bin/bash
set -e

int_handler()
{
    echo "Interrupted. Good choice."
    # Kill the parent process of the script.
    kill $PPID
    exit 1
}
trap 'int_handler' INT

echo "Please wait 5 seconds. Are you sure you cannot avoid checking messages?"
sleep 5
while true; do
    read -p "Are you sure (y/n)? " yn
    case $yn in
        [Yy]* ) break;;
        * ) exit;;
    esac
done

echo "I will block you for 30 more seconds, you can still interrupt it."
sleep 30
echo "ok, unblocked"
sudo sed -i -r '/BLOCKME/s/^/# /g' /etc/hosts
