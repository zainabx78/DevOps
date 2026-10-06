#!/bin/bash

#!/bin/bash

# ===========================================================
# Challenge 4: Backup Script for Text Files
#
# Asks the user for a source directory and checks it exists.
# Creates a backup directory named with the date and time,
# copies all .txt files into it, and displays how many
# files were backed up.
#
# Concepts used: functions, user input (read -r),
# if/else conditionals, file test operators (-d),
# the date command, copying files (cp), piping (|),
# counting files (wc -l), error handling (exit 1)
# ==========================================================


backup(){

    # Ask the user for the source directory
    echo "Enter source directory: "
    read -r source

    # Check the source directory exists
    if [ ! -d "$source" ]; then
        echo "Error: The directory '$source' does not exist"
        exit 1
    fi

    # Count how many .txt files are in the source directory
    # 2>/dev/null hides the error message if there are no .txt files
    file_count=$(ls "$source"/*.txt 2>/dev/null | wc -l)

    # If there are no .txt files, there's nothing to back up
    if [ "$file_count" -eq 0 ]; then
        echo "No .txt files found in '$source'. Nothing to back up."
        exit 1
    fi

    # Create the backup directory name with a timestamp
    # e.g. backup_2026-10-04_14-30
    backup_dir="backup_$(date +%Y-%m-%d_%H-%M)"

    # Create the backup directory (-p = only if it doesn't already exist)
    mkdir -p "$backup_dir"
    echo "Backup directory created: $backup_dir"

    # Copy all .txt files into the backup directory
    echo "Copying .txt files..."
    cp "$source"/*.txt "$backup_dir"

    # Show how many files were backed up
    echo "Backup complete! Files backed up: $file_count"
}


backup