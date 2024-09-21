#!/bin/bash

COMMAND_LIST="commands.txt"

# Check if the command list file exists
if [ ! -f "$COMMAND_LIST" ]; then
    echo "Error: File $COMMAND_LIST does not exist."
    exit 1
fi

# Read each command from the command list file
while IFS= read -r command; do
    # Skip empty lines and lines starting with #
    [[ -z "$command" || "$command" =~ ^# ]] && continue

    echo "Processing command: $command"

    # Copy the script file and make it executable
    if cp "$command.sh" /usr/local/bin/"$command"; then
        chmod +x /usr/local/bin/"$command"
        echo "Successfully added $command to /usr/local/bin/"
    else
        echo "Error: Failed to copy $command.sh to /usr/local/bin/"
    fi

done < "$COMMAND_LIST"

