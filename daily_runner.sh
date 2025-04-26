#!/bin/bash
# daily_runner.sh - macOS runner with structured logs and notifications

# Load user profile
source ~/.bash_profile 2>/dev/null || source ~/.zprofile 2>/dev/null

# Define log directory and file
LOG_DIR="$HOME/daily_runner_logs"
TODAY="$(date '+%Y-%m-%d')"
LOG_FILE="$LOG_DIR/run-$TODAY.log"

# Define commands with environment labels
# Format: "ENV COMMAND"
COMMANDS=(
    "bash /path/to/your_bash_script.sh"
    "python3 /path/to/your_python_script.py"
    "bash /path/to/another_script.sh"
    "python3 /path/to/another_script.py"
)

# Prepare log directory
mkdir -p "$LOG_DIR"

ALL_SUCCESS=true

# Header for new log file (only if empty)
if [[ ! -s "$LOG_FILE" ]]; then
    printf "%-20s | %-25s | %-10s | %-10s\n" "DATE" "SCRIPT" "ENV" "STATUS" > "$LOG_FILE"
    printf -- "-------------------------------------------------------------------------------\n" >> "$LOG_FILE"
fi

# Execute commands
for ENTRY in "${COMMANDS[@]}"; do
    ENV=$(echo "$ENTRY" | awk '{print $1}')
    SCRIPT_PATH=$(echo "$ENTRY" | awk '{print $2}')
    SCRIPT_NAME=$(basename "$SCRIPT_PATH")
    DATE_NOW="$(date '+%Y-%m-%d %H:%M:%S')"

    echo "$DATE_NOW Running: [$ENV] $SCRIPT_PATH"
    
    if eval "$ENTRY"; then
        STATUS="SUCCESS"
    else
        STATUS="FAILURE"
        ALL_SUCCESS=false
    fi

    # Write structured log line
    printf "%-20s | %-25s | %-10s | %-10s\n" "$DATE_NOW" "$SCRIPT_NAME" "$ENV" "$STATUS" >> "$LOG_FILE"
done

# Notification
if $ALL_SUCCESS; then
    osascript -e "display notification \"All scripts succeeded. Log: run-$TODAY.log\" with title \"Daily Runner ✅\""
else
    osascript -e "display notification \"Some scripts failed. Log: run-$TODAY.log\" with title \"Daily Runner ⚠️\""
fi
