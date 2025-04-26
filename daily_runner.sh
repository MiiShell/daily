#!/bin/bash
# daily_runner.sh - Run scripts and commands once daily

# Commands to run (bash, python, etc.)
COMMANDS=(
    "bash /path/to/your_bash_script.sh"
    "python3 /path/to/your_python_script.py"
    "/path/to/another_script.sh"
    "python3 /path/to/another_script.py"
)

# Execute each command
for CMD in "${COMMANDS[@]}"; do
    echo "Running: $CMD"
    eval "$CMD"
done
