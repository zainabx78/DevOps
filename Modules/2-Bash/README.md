# Bash Scripting Notes

My notes and practice scripts from learning Bash scripting: how to write small programs that tell a Linux computer what to do automatically.

## Modules

1. [Bash Intro](Bash-Notes/BashIntro.md) - What Bash is, writing your first script, the shebang (`#!/bin/bash`), comments, running scripts from anywhere, and piping.
2. [Variables and Parameters](Bash-Notes/Variables+Parameters.md) - Storing values, passing information into a script, and doing maths with arithmetic expansion.
3. [Conditionals](Bash-Notes/Conditionals.md)  - Making decisions in scripts with `if`, `else` and `elif`, plus comparison and logical operators.
4. [Loops](Bash-Notes/Loops.md) - Repeating actions with `while` and `for` loops, and controlling them with `break` and `continue`.
5. [Functions and Inputs](Bash-Notes/Functions+Inputs.md) - Grouping commands into reusable functions, reading user input, and validating or cleaning up bad data.
6. [Error Handling and Exit Codes](Bash-Notes/ErrorHandling+ExitCodes.md) - Catching errors, understanding exit codes (0 = success, 1 = fail), and using `set -e`, `set -u`, `set -x` and `set -o pipefail`.
7. [Environment and PATH](Bash-Notes/Environment+PATH.md) - Reading environment variables like `$HOME` and `$USER`, and making scripts available from anywhere permanently.
8. [Working With Files](Bash-Notes/WorkingWithFiles.md) - Reading and writing files, and checking file integrity with `md5sum` and `sha256sum` checksums.

## Practice Scripts

- [FirstScript.sh](Bash-Scripts/FirstScript.sh) - Practice script covering the different types of loops.
- [Arithmetic Calculator](Bash-Scripts/1-Arithmetic-Calculator.sh)
- [File Operations](Bash-Scripts/2-File-Operations.sh)
- [File Checker](Bash-Scripts/3-File-Checker.sh)
- [Backup Script](Bash-Scripts/4-Backup-Script.sh)
- [System Monitor](Bash-Scripts/5-System-Monitor.sh)

## Bash Script Game

- [Bash Battle Arena](<The Game-Bash-Battle-Arena.md>)
