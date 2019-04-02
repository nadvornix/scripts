
touch ~/.block_communications.log

type=$(cat ~/.block_communications.log |  tail -1 | awk '{print $3}')
if [ "$type" = "block" ]; then
    last_block_date=$(cat ~/.block_communications.log | grep 'block' | tail -1 | awk '{print $1 " " $2}')
    last_block_timestamp=$(date -d "$last_block_date" +%s)
    now=$(date +%s)
    diff=$((now-last_block_timestamp))
    printf '%dh:%dm since last unblocking\n' $(($diff/3600)) $(($diff%3600/60))
else
    echo "It is now unblocked"
fi
