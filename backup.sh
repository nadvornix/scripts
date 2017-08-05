#!/bin/sh
REPOSITORY=17977@ch-s011.rsync.net:backup

# Backup all of /home and /var/www except a few
# excluded directories
borg create --remote-path=borg1 -v --stats                          \
    $REPOSITORY::"{hostname}-{now:%Y-%m-%d}"    \
    /home/jiri                                  \
    /etc                                        \
    --exclude '/home/*/.cache'                  \
    --exclude '*.pyc' 			 \
	--exclude "*bitshares*"    \
	--exclude "*Mathematica*"  \
	--exclude "*Downloads*"    \
	--exclude "*.local*"       \
	--exclude "*.cache*"   \
	--exclude "*Applications*" \
	--exclude "*virtualenvs*" \
        --exclude "*dev*" 

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machine's archives also.
borg prune --remote-path=borg1 -v --list $REPOSITORY --prefix '{hostname}-' \
    --keep-daily=7 --keep-weekly=4 --keep-monthly=24
