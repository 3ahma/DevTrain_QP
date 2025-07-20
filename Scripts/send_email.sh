#!/bin/bash

TO="hamza@quizplus.com"
SUBJECT="Daily Email"

validate_time_window() {
    current_hour=$(date '+%H')
    current_minute=$(date '+%M')
    if [[ "$current_hour" -eq 13 && "$current_minute" -le 5 ]]; then
        return 0    # valid time window
    else
        echo "Script executed outside valid time window (12:50-12:55). Current time: $(date '+%H:%M')"
        echo "Script exiting without sending email."
        exit 1
    fi
}

get_service_usage() {
    SERVICE_NAME="send-email.service"

    CPU=$(systemctl show "$SERVICE_NAME" --property=CPUUsageNSec | awk -F= '{print $2}')
    MEM=$(systemctl show "$SERVICE_NAME" --property=MemoryCurrent | awk -F= '{print $2}')

    CPU_SEC=$(echo "$CPU / 1000000000" | bc -l)

    MEM_MB=$(echo "$MEM / 1048576" | bc -l)

    echo "Service Resource Usage:"
    echo "-----------------------"
    echo "CPU Usage: ${CPU_SEC}s"
    echo "Memory Usage: ${MEM_MB} MB"
}


validate_time_window

BODY=$(get_service_usage)

echo -e "Subject:${SUBJECT}\n\n${BODY}" | msmtp "$TO"
