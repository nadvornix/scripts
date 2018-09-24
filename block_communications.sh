#!/bin/bash

# put lines like these to you /etc/hosts
# 127.0.0.1	mail.google.com	# BLOCKME

# -i means inplace (instead of piping)

sudo sed -i -r '/BLOCKME/s/^#[# ]+//g' /etc/hosts


