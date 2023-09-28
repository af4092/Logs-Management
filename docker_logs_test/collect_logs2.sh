#!/bin/bash

# Set the output JSON file path
OUTPUT_JSON_FILE="logs.json"

# Define container names and their respective log files
CONTAINER_LOGS=(
    "server:server_logs.txt"
    "sender:sender_logs.txt"
)

# Initialize an empty JSON array
JSON_ARRAY="["

# Iterate through each container and collect logs
for CONTAINER_LOG in "${CONTAINER_LOGS[@]}"
do
    # Split container name and log file
    IFS=':' read -ra CONTAINER_INFO <<< "$CONTAINER_LOG"
    CONTAINER_NAME="${CONTAINER_INFO[0]}"
    LOG_FILE="${CONTAINER_INFO[1]}"

    # Get logs for the container and save to a log file
    docker logs "$CONTAINER_NAME" > "$LOG_FILE"

    # Iterate through each log entry and format them as JSON
    while IFS= read -r LOG_LINE; do
        TIMESTAMP=$(echo "$LOG_LINE" | cut -d' ' -f1)
        LOG=$(echo "$LOG_LINE" | cut -d' ' -f2-)
        JSON_ARRAY+=$(printf '{"container_name": "%s", "timestamp": "%s", "log": "%s"},' "$CONTAINER_NAME" 
"$TIMESTAMP" "$LOG")
    done < "$LOG_FILE"
done

# Remove the trailing comma and close the JSON array
JSON_ARRAY=${JSON_ARRAY%,}
JSON_ARRAY+="]"

# Write the JSON array to the output file
echo "$JSON_ARRAY" > "$OUTPUT_JSON_FILE"

# Clean up log files
for CONTAINER_LOG in "${CONTAINER_LOGS[@]}"
do
    IFS=':' read -ra CONTAINER_INFO <<< "$CONTAINER_LOG"
    LOG_FILE="${CONTAINER_INFO[1]}"
    rm "$LOG_FILE"
done

echo "Logs collected and saved to $OUTPUT_JSON_FILE"

