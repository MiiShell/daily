#!/bin/bash
# daily_runner.sh - macOS daily runner with notification

# Load user profile (macOS cron needs this)
source ~/.bash_profile 2>/dev/null || source ~/.zprofile 2>/dev/null

# Define commands
COMMANDS=(
    "/bin/bash /path/to/your_bash_script.sh"
    "/usr/bin/python3 /path/to/your_python_script.py"
    "/path/to/another_script.sh"
    "/usr/bin/python3 /path/to/another_script.py"
)

# Execute commands
for CMD in "${COMMANDS[@]}"; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') Running: $CMD"
    eval "$CMD"
done

# Send macOS notification
osascript -e 'display notification "All scripts executed successfully!" with title "Daily Runner"'
