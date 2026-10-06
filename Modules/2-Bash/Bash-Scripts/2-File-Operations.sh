#!/bin/bash

# ===========================================================
# Challenge 2: File Operations Script
#
# Creates a directory called 'bash_demo', moves into it and
# creates a file called 'demo.txt'. Writes today's date into
# the file, then displays the file's contents on screen.
#
# Concepts used: creating directories (mkdir), navigating (cd),
# creating files (touch), writing with redirection (>),
# the date command, displaying contents (cat)
# ===========================================================




# Create a directory 
mkdir /c/Users/zaina/OneDrive/Desktop/DevOps/Modules/bash_demo
echo "Directory 'bash_demo' created."

# Create a file in that directory
cd /c/Users/zaina/OneDrive/Desktop/DevOps/Modules/bash_demo
touch demo.txt
echo "File 'demo.txt' created."

# Bash has a command called date that gives you the current date and time.
echo "Todays date: $(date)" > demo.txt


#Another way of displaying date
# echo "This file was created by a Bash script on $(date +%Y-%m-%d)" > demo.txt



echo "File contents: $(cat demo.txt)"
