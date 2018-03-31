#!/bin/bash

# Manual: adddotfile.sh path to file.
# updatedotfiles.sh se pravidelně spouští a aktualizuje (?)

# TODO:
# - info a/ what files I have synchronized
# - something like ls-synced that write * on synced files


set -e
set -x

# RealPath=`realpath $1`
# Dir=`dirname $RealPath`
# mkdir -p "$Dir"

# RealPath=`realpath $1`
Pwd=$(pwd)

RealPath=$(realpath $1)
Dir=$(dirname $RealPath)

mkdir -p ~/Dropbox/dotfiles$Dir

mv $RealPath ~/Dropbox/dotfiles$Dir

ln -s  ~/Dropbox/dotfiles$RealPath $RealPath

# mkdir -p ~/Dropbox/dotfiles-symlinks$Dir

# ln -s ~/Dropbox/dotfiles$RealPath ~/Dropbox/dotfiles-symlinks$Dir
