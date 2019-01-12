#!/bin/bash
# pcmanfm
# touch /home/jiri/tmp.xxx
scrot -s /home/jiri/tmp.png 2>&1 > /home/jiri/tmp.xxx;
xclip -sel clip -t image/png -i /home/jiri/tmp.png
