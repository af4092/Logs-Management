#!/bin/bash

# Set the output JSON file path
OUTPUT_JSON_FILE="logs.json"

# Define an array to store container names and their respective log files
declare -A CONTAINER_LOGS=(
    ["server"]="nodejs_server_logs.txt"
    ["sender"]="message_sender_logs.txt"
)

# Initialize an empty JSON array
JSON_ARRAY="["

# Iterate through each container and collect logs
for CONTAINER_NAME in "${!CONTAINER_LOGS[@]}"
do
    # Get logs for the container and save to a log file
    docker logs "$CONTAINER_NAME" > "${CONTAINER_LOGS[$CONTAINER_NAME]}"

    # Iterate through each log entry and format them as JSON
    while IFS= read -r LOG_LINE; do
        TIMESTAMP=$(echo "$LOG_LINE" | cut -d' ' -f1)
        LOG=$(echo "$LOG_LINE" | cut -d' ' -f2-)
        JSON_ARRAY+=$(printf '{"container_name": "%s", "timestamp": "%s", "log": "%s"},' "$CONTAINER_NAME" 
"$TIMESTAMP" "$LOG")
    done < "${CONTAINER_LOGS[$CONTAINER_NAME]}"
done

# Remove the trailing comma and close the JSON array
JSON_ARRAY=${JSON_ARRAY%,}
JSON_ARRAY+="]"

# Write the JSON array to the output file
echo "$JSON_ARRAY" > "$OUTPUT_JSON_FILE"

# Clean up log files
for LOG_FILE in "${CONTAINER_LOGS[@]}"
do
    rm "$LOG_FILE"
done

echo "Logs collected and saved to $OUTPUT_JSON_FILE"

