# Error Handling and Exit Codes

## Error Handling

### IF statements for error handling

- Example1 - A script that causes an error (10/0 gives us an error)

```bash
#!/bin/bash

num1=10
num2=0

results=$((num1 / num2))

echo "The result is: $result"

```

- To create error handling within this script:
  - Using an IF statment with error code 1

```bash
#!/bin/bash

num1=10
num2=0

if [ num2 -eq 0 ]; then 
    echo "Error - Division by zero is not allowed"
    exit 1
fi
# This if statement is how we handle the error.
# If the num2 is 0, we throw an error message.
# Exit 1 = failed exit code - ends the script here.

results=$((num1 / num2))

echo "The result is: $result"

```

- Example2 - Script identifying if file exists or not.

```bash
#!/bin/bash

FILE="/nonexistent"

if [[ -f "$FILE" ]]; then # -f used to check file exists.
    echo "The file exists."

else
    echo "File does not exist"

fi 


```


## EXIT CODES

- Whenever a command or script ends, it returns an exit code to the system.
- Exit code = numerical value that represents whether the command/script was successful or not.

- 0 = SUCCESS
- 1 = FAIL

- To check the exit code in terminal = 
  - Run a command e.g. `ls`
  - Check if it was successful or not: `echo $?`
  - This will give the error code 0 as it was successful.

### Using exit codes for error handling


```bash
#!/bin/bash

#This command checks if a command exists (git) and then discards the error message to /dev/null
command -v git 2>/dev/null 

if [[ $? -ne 0 ]]; then 
    echo "git is not installed, please install it.
else
    echo "git is installed"
fi 
```

### Set -e

- When using set -e in any script, the script will stop executing as soon as there's a non-0 exit code.
- This means it will stop as soon as there's any error.

- Example - this script below uses a nonexistent command to create an error. 
  - This means that the script should not run past the error and we should never see the `after the script` statement printed in terminal.

```bash
#!/bin/bash

set -e 

echo "Before the script"

nonexistentcommand 

echo "After the script"

```

### Set -u

- Forces bash script to stop if it encounters an uninitialized variable. 
- Prevents scenario where missing data leads to unexpected behaviour.

- Example:
  - The script uses a variable that doesn't exist (X).
  - It will stop executing as soon as it encounters that error.
  - It  won't print anything.

```bash
#!/bin/bash

set -u

echo "The value to variable X is: $X"

```

- Example 2: 
  - We haven't set variable W.
  - Even though X and Y were initialized correctly, the script stops and doesn't run because W wasn't initialized.

```bash
#!/bin/bash

set -u

X=10
Y=20

Z=$((X + Y + W))

echo "Z equals $Z"

```


### Set -x and set +x
- Good for debugging and troubleshooting
- Prints each command that will be executed to the terminal before it's executed. 
- Use `set +x` at the end of the part of the script you want to debug.
- Helpful if you only want to debug a specific part of the script.

- Example: This script does some basic commands and setting a variable. 
  - In the terminal, you should see the commands before the commands are run. 

```bash
#!/bin/bash

set -x

echo "This is a test"

X=10

echo "The value of X is: $X

```

- Example 2: 

```bash
#!/bin/bash

set -x

X=10
Y=20

Z=$((X + Y))

echo "The value of Z is: $Z"

set +x

echo "After the script"

```
- Use `set +x` at the end of the part of the script you want to debug.
- The rest won't show the commands before running. 




### Set -eux

- Using all options at once (e, u, x)
- This will stop the script if there's an error (e).
- This will stop the script if there's an uninitialized variable (u).
- This will print each command before execution (x).

- Example:
  - This script won't print all commands because of x because it'll stop at the uninitialized value of X.
  - In the terminal you'll only see the first echo command. 
  - Stops at the failing command at the end.

```bash
#!/bin/bash

set -eux

echo "This is a test"

echo "The value of X is: $X"

nonexistentcommand

```



### More Set commands

- `set -o nounset` 
  - This Equivalent to set -u
  - Catches uninitialized variables.

- `Set -o errexit` 
  - This is same as set -e.
  - Causes the shell to exit if any invoked command fails.


- `Set -o pipefail`
  - Causes a pipeline to return the exit status of the last command in the pipeline that exited with a non-0 status.
  - Example: This script will fail at cat step. 

```bash
#!/bin/bash

set -o pipefail

cat nonexistent file | grep "something"

```


