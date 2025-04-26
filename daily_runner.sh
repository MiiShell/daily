#!/bin/bash
# daily_runner.sh - macOS optimized daily runner

# Load user profile for environment variables (important on macOS cron)
source ~/.bash_profile 2>/dev/null || source ~/.zprofile 2>/dev/null

# Define commands to execute
COMMANDS=(
    "/bin/bash /path/to/your_bash_script.sh"
    "/usr/bin/python3 /path/to/your_python_script.py"
    "/path/to/another_script.sh"
    "/usr/bin/python3 /path/to/another_script.py"
)

# Execute each command
for CMD in "${COMMANDS[@]}"; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') Running: $CMD"
    eval "$CMD"
done
