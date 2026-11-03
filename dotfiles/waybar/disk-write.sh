#!/usr/bin/env bash
# Streams Waybar JSON for the disk that holds the root filesystem.
# text: percent of time the disk was busy (reads + writes) over the last interval
# tooltip: write throughput in MB/s over the same interval

DEV=sda        # OS disk (root is on sda3)
INTERVAL=2     # seconds

# /proc/diskstats: field 10 = sectors written, field 13 = ms spent doing I/O
read_stats() { awk -v d="$DEV" '$3==d {print $13, $10}' /proc/diskstats; }

read -r prev_busy prev_sec < <(read_stats)

while true; do
    sleep "$INTERVAL"
    read -r busy sec < <(read_stats)

    util=$(( (busy - prev_busy) * 100 / (INTERVAL * 1000) ))
    (( util > 100 )) && util=100
    (( util < 0 )) && util=0

    mbs=$(awk -v s=$((sec - prev_sec)) -v i="$INTERVAL" \
        'BEGIN { printf "%.1f", s * 512 / 1000000 / i }')

    prev_busy=$busy
    prev_sec=$sec

    printf '{"text":"%d%%","tooltip":"Write: %s MB/s","class":"%s"}\n' \
        "$util" "$mbs" "$([ "$util" -ge 80 ] && echo critical || echo normal)"
done
