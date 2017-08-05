# Random scripts

## Battery check
add to crontab -e
    * * * * * /home/jiri/scripts/battery_check.sh

## Backuping
add to /etc/anacrontab
    1	15	backuping 	/home/jiri/scripts/backup.sh


