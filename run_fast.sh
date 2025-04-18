#!/bin/bash

export PATH="$HOME/.nvm/versions/node/v23.11.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
exec >> $HOME/internet-speed-logs/combined/cron_debug.log 2>&1
echo "==== $(date) ===="

CSV_OUT="$HOME/internet-speed-logs/combined/internet_speeds.csv"
NODE="$HOME/.nvm/versions/node/v23.11.0/bin/node"
FAST="$HOME/.nvm/versions/node/v23.11.0/bin/fast"

#sleep 40

FAST_JSON=$($NODE $FAST --upload --json)
echo "$FAST_JSON" >> $HOME/internet-speed-logs/combined/debug_fast_raw.log

if jq empty <<< "$FAST_JSON" 2>/dev/null; then
    DOWNLOAD=$(jq -r '.downloadSpeed' <<< "$FAST_JSON")
    UPLOAD=$(jq -r '.uploadSpeed' <<< "$FAST_JSON")
    LATENCY=$(jq -r '.latency' <<< "$FAST_JSON")
    TIMESTAMP=$(date --iso-8601=seconds)
    echo "$TIMESTAMP,fast,$DOWNLOAD,$UPLOAD,$LATENCY" >> "$CSV_OUT"
else
    echo "$(date --iso-8601=seconds) - ERROR: Invalid JSON from fast"
fi
