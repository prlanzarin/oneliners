#!/bin/bash
# track-egress-analyzer.sh: Analyzes RTC logs to find audio/opus tracks experiencing clock skew and identifies related egress events
# Usage: ./rtc-track-egress-analyzer.sh /path/to/logfile.log
# Author: prlanzarin - 2025-03-06

[ $# -eq 0 ] && { echo "Usage: $0 /path/to/logfile.log"; exit 1; }
LOG_FILE="$1"
[ ! -f "$LOG_FILE" ] && { echo "Error: Log file not found"; exit 1; }

echo "=== Track IDs with clock skew in audio/opus streams ==="
track_ids=($(grep -E "clock skew.*\"mime\":\s*\"audio/opus\"" "$LOG_FILE" | grep -oP '"trackID":\s*"\K[^"]+' | sort -u))

echo "Found ${#track_ids[@]} unique track IDs:"
printf '"%s" ' "${track_ids[@]}"
echo -e "\n"

declare -a all_matching_entries

echo "=== Egress entries for affected track IDs ==="
for track_id in "${track_ids[@]}"; do
    matching_entries=$(grep -E "egress.*$track_id|$track_id.*egress" "$LOG_FILE")
    if [ -n "$matching_entries" ]; then
        while IFS= read -r line; do
            all_matching_entries+=("$line")
        done <<< "$matching_entries"
    fi
done

if [ ${#all_matching_entries[@]} -eq 0 ]; then
    echo "No egress entries found for any track ID with clock skew"
else
    printf '%s\n' "${all_matching_entries[@]}"
fi

echo -e "\n=== Summary ==="
echo "Track IDs with clock skew (${#track_ids[@]}):"
printf '"%s" ' "${track_ids[@]}"
echo -e "\nEgress entries for affected tracks: ${#all_matching_entries[@]}"
