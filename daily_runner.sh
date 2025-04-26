#!/bin/bash
# daily_runner.sh - Runs other scripts once daily

# Define script paths
SCRIPTS=(
    "/path/to/first_script.sh"
    "/path/to/second_script.sh"
    "/path/to/third_script.sh"
)

# Execute each script
for SCRIPT in "${SCRIPTS[@]}"; do
    if [[ -x "$SCRIPT" ]]; then
        "$SCRIPT"
    else
        echo "Warning: $SCRIPT is not executable or not found."
    fi
done
