#!/bin/bash

# Paths
LOG_DIR="$HOME/internet-speed-logs/logs"
COMBINED_FILE="$HOME/internet-speed-logs/combined/internet_speeds.csv"

# Timestamp
NOW=$(date -Iseconds)

# Run speedtest
RAW_JSON=$(speedtest -f json)
echo "$RAW_JSON" >> "$LOG_DIR/speedtest_raw.log"

# Extract and convert
DOWNLOAD=$(echo "$RAW_JSON" | jq '.download.bandwidth * 8 / 1000000')
UPLOAD=$(echo "$RAW_JSON" | jq '.upload.bandwidth * 8 / 1000000')
LATENCY=$(echo "$RAW_JSON" | jq '.ping.latency')

# Write CSV entry
echo "$NOW,speedtest,$DOWNLOAD,$UPLOAD,$LATENCY" >> "$COMBINED_FILE"
