#!/bin/bash

# ===========================================================
# Challenge: System Monitor Script
#
# Displays a snapshot of the system's current health:
# CPU usage, memory usage (total, used, free), disk usage,
# and the top 5 processes using the most memory.
#
# Note: Must be run in a Linux environment (e.g. WSL), as
# top, free and ps --sort don't work in Git Bash.
#
# Concepts used: variables, command substitution $( ),
# piping (|), system commands (top, free, df, ps)
# ===========================================================




# Create a log file name with the current date and time
# e.g. system_report_2026-10-04_14-32-10.log
log_file="system_report_$(date +%Y-%m-%d_%H-%M-%S).log"

system_monitor(){

    # CPU usage
    cpu=$(top -bn1 | grep "Cpu(s)")
    echo "Current CPU usage: $cpu "

    # Memory 
    mem=$(free -h) 
    echo "Memory Usage:"
    echo "$mem"

    # Disk 
    disk=$(df -h )
    echo "Disk Usage: $disk "

    # Top 5 processes 
    top5=$( ps aux --sort=-%mem | head -n 6 )
    echo "Top 5 processes by memory: $top5 "
}

# Run the function, show the output on screen AND save it to the log file
system_monitor | tee "$log_file"
# The tee command takes whatever is sent into it and sends it two places at once: onto your screen and into a file.

echo "Report saved to: $log_file"

