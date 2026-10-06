# Environment and PATH

## Change PATH permenantly 


1. In the bash terminal:
   - `mkdir my_scripts`
  - `vi my_scripts/hello_world/.sh` - Creating a file in the new folder.
  - In the file:

```bash    
#!/bin/bash

echo "hello world"

```
  - To save and exit script - press `:` and type `wq!`.

2. Give the file executeable permissions `chmod +x my_scripts/hello_world.sh`

3. To make this file permenant, need to add it to .bashrc file.
   - Append a line to the script file to add the file to bashrc file - Run this in terminal `echo "export PATH=$PATH:~/my_scripts" >> ~/.bashrc`
   - This command adds that export line into the script.

4. Then need to reload .bashrc file to reflect the changes. `source ~/.bashrc`
   - This script should now be accessible from anywhere!
   - The change will persist even after a reboot or new shell session.


## Reading Environment Variables

 - To access variables within a script = `$`
 - Environment variables are always in CAPITAlS.

```bash    
#!/bin/bash

#Shows path of home directory.
echo "Home Directory: $HOME"

#Shows current user
echo "Current User: $USER"

#Print info about the OS
echo "OS Type: $OSTYPE"

```

- Can also reference these environment variables using local variables:

```bash    
#!/bin/bash

my_home="$HOME"
my_user="$USER"
MY_os="$OSTYPE"


#Shows path of home directory.
echo "Home Directory: $my_home"

#Shows current user
echo "Current User: $my_user"

#Print info about the OS
echo "OS Type: $my_os"

```


## Standard Environment Variables

- valuable insights into the system.
- Commonly used environment variables:

```bash    
#!/bin/bash

# Gives username of currently logged in user.
echo "Username: $LOGNAME" 

# Gives current shell e.g. zsh or bash
echo "Shell: $SHELL"

# Prints current working directory
echo "Current Directory: $PWD"


# Tells you the directories in PATH and binaries etc.
echo "Executable Paths: $PATH"

# Tells you the default language
echo "Default Language: $LANG"


```
