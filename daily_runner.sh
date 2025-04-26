#!/bin/bash
# daily_runner.sh - macOS daily runner with success notification

# Load user profile
source ~/.bash_profile 2>/dev/null || source ~/.zprofile 2>/dev/null

# Define commands
COMMANDS=(
    "/bin/bash /path/to/your_bash_script.sh"
    "/usr/bin/python3 /path/to/your_python_script.py"
    "/path/to/another_script.sh"
    "/usr/bin/python3 /path/to/another_script.py"
)

ALL_SUCCESS=true

# Execute commands
for CMD in "${COMMANDS[@]}"; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') Running: $CMD"
    if ! eval "$CMD"; then
        echo "Error: Command failed -> $CMD"
        ALL_SUCCESS=false
    fi
done

# Notify based on result
if $ALL_SUCCESS; then
    osascript -e 'display notification "All scripts executed successfully!" with title "Daily Runner ✅"'
else
    osascript -e 'display notification "Some scripts failed. Check logs!" with title "Daily Runner ⚠️"'
fi
