# BASH SCRIPTING AND PIPING

## INTRO

- Bash = A command-line tool to interact with computer.
- Bash Script = A file containing a series of commands you want the computer to execute automatically. 

- Shebang:
  - = `#!`
  - The first line in the script:
  - `#!/bin/bash`
  - It tells the computer to use bash to run the script. 
  - Extension of script = `.sh`

- Running the script:
  - Make it executable: `chmod +x your_script`
  - Run the script: `./your_script`

- Variables = store value and can use them within the script
  - E.g. `name="Ahmed"` --> `echo "Hello, $name"`

- Comments = use `#` to comment/describe different commands.

- Conditionals = Make decisions with if statements
  - E.g. `if [ $name == "Alice" ]; then echo "Hi Alice!" fi`

- Loops = Repeat actions with for or while loops
  - E.g. `for i in 1 2 3; do echo "Number $i" done`

- Functions = Group commands for resuse:
  - E.g. `greet() { echo "Hello, $1!" } greet "Alice"`

- User Input = Get input from users
  - E.g. `read -p "Enter your name: " name echo "Hello, $name!"`


## FIRST SCRIPT: 

1. Create the script file = `touch first_script.sh`
2. Edit the file = `vi first_script.sh`
   
   ```
    #!/bin/bash 

    echo "Hello World"

   ```

3. Grant it executable permissions = `chmod +x first_script.sh`
4. Can check which permissions it has = `ls -la`
5. Run the script = `./first_script.sh`



## Shebang

- `#!/bin/bash`  = tells the OS system how to interpret this file. 
  - Interprets it as binary bash. 
  - Points to the specific shell that should handle this script. 
  - E.g. If you're writing script in python, use `#!/usr/bin/python3` - uses python interpreter. 


- To run the script:
  - `./first_script.sh`
  - `sh first_script.sh` --> 
  - `bash first_script.sh` --> Use these 2 commands (sh and bash) when the bash interpretor hasn't been included in the script. 

## Comments

- Single line comments = `#` Anything on the line is a comment.
- Multi line comments = `: '` start of comment and ends in `'`.
- Necessary to keep the purpose of the script clear throughout. 


## Running Scripts from Anywhere

- Place script in directory that's in a PATH environment variable.
- Check which directories are in $PATH = `echo $PATH`
- Any executable file placed in one of these directories can be run from anywhere. 
- Most common place to place scripts = `/usr/local/bin` (in the $PATH environment variable)
- Moving a script to that directory = `sudo mv first_script.sh /usr/local/bin/first_script` 
  - This also renames it to `first_script` so it's easier to run.
- Change permissions = `sudo chmod +x /usr/local/bin/first_script`
- Now you can run the script as just `first_script` and it will run it as it's in the $PATH env variable - dont need `./`.
- Even if you change directories, you can run `first_script` from ANYWHERE.


## Piping 

- pass output of one command as an input to another. 

Example:

```bash
#!/bin/bash

get_file_count() {
  local directory="$1"
  local file_count

  file_count=$(ls "directory" | wc -l ) #$ used when running command.

  echo "Number of files in $directory: $file_count"

}

get_file_count "./"

```

- Example 2:
  - Prints 2nd line (time of log) from a log file - dependent on parameter inserted at time of calling function.


```bash
#!/bin/bash

search_logs(){
  local search_term="$1"
  grep "$search_term" log.txt | awk '{ print $2 }'

}

search_logs "ERROR"

```