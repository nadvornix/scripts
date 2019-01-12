#!/bin/bash
# add to /etc/anacrontab
# 1	15	backuping 	/home/jiri/scripts/backup.sh

# Useful commands:
# extract file from backup to current dir:
# borg extract 17977@ch-s011.rsync.net:backup::jiri-laptop-2018-08-29 "home/jiri/tmp.png"
# Listing of all files: borg list  17977@ch-s011.rsync.net:backup::jiri-laptop-2018-08-29
# listing all backups: borg list 17977@ch-s011.rsync.net:backup # backup is name of "repository"

# Amount of space I use:
# ssh 17977@ch-s011.rsync.net "du -h"

# list last backups:
# borg  list -v --remote-path=borg1 17977@ch-s011.rsync.net:backup

date >> /home/jiri/borg.log

REPOSITORY=17977@ch-s011.rsync.net:backup

# Backup all of /home and /var/www except a few
# excluded directories
borg create --remote-path=borg1 -v --stats                          \
  $REPOSITORY::"{hostname}-{now:%Y-%m-%d}"    \
  /home/jiri                                  \
  /etc                                        \
  --exclude '/home/*/.cache'                  \
  --exclude '*.pyc' 			 \
	--exclude "*Mathematica*"  \
	--exclude "*Downloads*"    \
	--exclude "*.local*"       \
	--exclude "*.cache*"   \
	--exclude "*tmp*"   \
	--exclude "*mathematica*"   \
	--exclude "*bt-downloads*"   \
	--exclude "*Applications*" \
  --exclude "*virtualenvs*" \
  --exclude "*dev*" >> /home/jiri/borg.log

echo "----" >> /home/jiri/borg.log

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machine's archives also.
borg prune --remote-path=borg1 -v --list $REPOSITORY --prefix '{hostname}-' \
    --keep-daily=7 --keep-weekly=20 --keep-monthly=240 --keep-yearly=100 >> /home/jiri/borg.log
