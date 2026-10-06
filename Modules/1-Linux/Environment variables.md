# Environment Variables

- Variables that are set in the environment and effect the behaviour of processes on the system.
- Store config settings and important system info. 

### $PATH 
- Directories where the system looks for executable files

### $HOME
- The current user's home directory

### $USER
- The current user's username

### $SHELL
- The shell program in use


## Ways to set an environment variable:

### 1. Temporary setting
- Using the export command
- Only used in the temporary session.
- E.g. `export JAVA_HOME=/usr/bin/java`
- `echo $JAVA_HOME`  = to see if the variable has been set. 

- E.g.  `export MY_VAR="Hello World"` = sets the variable as hello world for this session only.


### 2. Permanant setting
- .zshrc and .bashrc files
- Using each file for the respective shell - e.g. .bashrc for bash shell.
- Config files that live in the home directory.
- Contain all the config for your shell. 
- Add the export command to that file = permanant setting because it runs everytime the system loads up. 
- To apply any changes in the file = `source .zshrc`

- E.g. `vim .zhrc`
- press `o` once in the file --> goes to next line and insert mode (allows you to edit).
- Add the export command in there. 
- To apply any changes in the file = `source .zshrc`
- When refreshing session, the environment variable will still exist. 

## Environment Variables in the Terminal

- `printenv` = prints the current environment variables.
- `env` = also prints the environment variables.
- `echo $HOME` = Shows the value of the variable.


### Adding a directory to $PATH:

- `echo $PATH` = Shows all the directories in PATH where there's environment variables.
- Adding a new directory in $PATH = `export PATH=$PATH:/home/ubuntu`
- Now, any script in /home/ubuntu will be recognized as a program.

### Creating a script with an env variable

- `vim greet.sh` --> creates a file and enters it. 
- Use this script inside:

```
#!/bin/bash
# A simple script to greet the user
echo "Hello, $USER! Welcome to $HOSTNAME."

```
- Grant it the executable permissions `chmod +x greet.sh`
- Now you can execute this file: `./greet.sh`. BUT this file is seen as a program as it's in the /home/ubuntu directory which was added to the env variable in the previous step. 
- THIS CAN RUN WITHOUT `./`!!!
- `greet.sh` --> don't need to use `./` to run this as it's seen as a program on it's own. 


### ALIASES

- Shortcuts for simplifying commands:
  - `alias` --> command that shows aliases for all commands. 

- Setting an alias:
  - `alias hello='echo "Hello World"'`
  - Now when you run `hello`, it will give you Hello World. 
  - This is temporary!

To make an alias permanent:
  - Add that alias command to the .zshrc file. 
  - Save changes = `source .zshrc`
  - Makes it permanent. 

Alias does not work inside a shell script
Bash does not expand aliases in non-interactive scripts by default. Use a shell function instead, or add shopt -s expand_aliases at the top of the script before the alias declaration.