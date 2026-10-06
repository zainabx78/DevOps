#!/bin/bash

# ===========================================================
# Challenge 3: File Checker with Permissions
#
# Asks the user for a file path and checks if the file exists.
# If it doesn't, the script stops with an error.
# If it does, it checks and reports whether the file is
# executable, readable and writable.
#
# Concepts used: functions, user input (read -r),
# if/else conditionals, file test operators (-f, -x, -r, -w),
# error handling (exit 1)
# ===========================================================



script_checker(){
    echo "Please enter a file name to check:"
    read -r file_name 
    # read treats \ as a special character and removes it. Adding -r stops that

    # Checks if the file exists
    if [ -f $file_name ]; then 
        echo "This file exists"
    else
        echo "This file doesn't exist"
        exit 1
    fi

    # Checks if the file is executable
    if [ -x "$file_name" ]; then 
        echo "This file is executable"
    else
        echo "This file is not executable"
    fi

    # Checks if the file is readable
    if [ -r "$file_name" ]; then 
        echo "This file is readable"
    else
        echo "This file is not readable"
    fi

    # Checks if the file is writable
    if [ -w "$file_name" ]; then 
        echo "This file is writable"
    else
        echo "This file is not writable"
    fi
}


script_checker