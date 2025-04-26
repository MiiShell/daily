#!/bin/bash
# daily_runner.sh - macOS daily runner with logging and notifications

# Load user profile
source ~/.bash_profile 2>/dev/null || source ~/.zprofile 2>/dev/null

# Define log files
LOG_DIR="$HOME/daily_runner_logs"
SUCCESS_LOG="$LOG_DIR/success.log"
FAILURE_LOG="$LOG_DIR/failure.log"

# Define commands
COMMANDS=(
    "/bin/bash /path/to/your_bash_script.sh"
    "/usr/bin/python3 /path/to/your_python_script.py"
    "/path/to/another_script.sh"
    "/usr/bin/python3 /path/to/another_script.py"
)

# Prepare log directory
mkdir -p "$LOG_DIR"

# Clean old logs
: > "$SUCCESS_LOG"
: > "$FAILURE_LOG"

ALL_SUCCESS=true

# Execute commands
for CMD in "${COMMANDS[@]}"; do
    TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "$TIMESTAMP Running: $CMD"
    if eval "$CMD"; then
        echo "$TIMESTAMP SUCCESS: $CMD" >> "$SUCCESS_LOG"
    else
        echo "$TIMESTAMP FAILURE: $CMD" >> "$FAILURE_LOG"
        ALL_SUCCESS=false
    fi
done

# Notify based on result
if $ALL_SUCCESS; then
    osascript -e 'display notification "All scripts executed successfully!" with title "Daily Runner ✅"'
else
    osascript -e 'display notification "Some scripts failed. Check failure.log!" with title "Daily Runner ⚠️"'
fi
