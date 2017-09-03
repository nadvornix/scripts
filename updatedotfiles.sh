#!/bin/bash
set -e
# set -x

dotfilesPath=/home/jiri/Dropbox/dotfiles
cd $dotfilesPath
find . -type f | 
while read l;
do
	f=${l#.}
	Dir=$(dirname $f)
	mkdir -p $Dir
	if [ -e $f ]
	then
		if [ ! -L $f ];
		then
			# echo $f "exists and is regular file or dir skipping.";
			echo $f "exists and is not asymlink -> skipping.";
		fi
	else
		ln -s $dotfilesPath$f $f;
	fi

done
