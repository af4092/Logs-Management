#!/bin/bash

# Set the output JSON file path
OUTPUT_JSON_FILE="logs.json"

# Define an array to store container names
CONTAINER_NAMES=("server" "sender")

# Initialize an empty JSON array
JSON_ARRAY="["

# Iterate through each container and collect logs
for CONTAINER_NAME in "${CONTAINER_NAMES[@]}"
do
    # Get logs for the container and format them as JSON
    LOGS=$(docker logs "$CONTAINER_NAME" --since $(date -u '+%Y-%m-%dT%H:%M:%SZ' --date="-1 minutes") 
--timestamps --format '{"container_name": "'$CONTAINER_NAME'", "log": "{{.Timestamp}} {{.Text}}"}')

    # Append the formatted logs to the JSON array
    JSON_ARRAY+="$LOGS,"
done

# Remove the trailing comma and close the JSON array
JSON_ARRAY=${JSON_ARRAY%,}
JSON_ARRAY+="]"

# Write the JSON array to the output file
echo "$JSON_ARRAY" > "$OUTPUT_JSON_FILE"

echo "Logs collected and saved to $OUTPUT_JSON_FILE"
