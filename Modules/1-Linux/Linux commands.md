# Linux

## Linux commands

- ls      = list all files/directories
- ls -a   = shows all files/directories included hidden ones
- ls -l   = lists all files/directories but with more detail
- ls -R   = lists all directories downstream of a folder. 
- lsof    = lists the open files and the associated processes. 
- cd      = change directory
- pwd     = prints working directory
- mkdir   = creates a directory
- rmdir   = removes empty directories
- rm -r   = removes directory even when it's not empty.
- ps auxf = can see all the processes that are running.
- touch   = creates a file
- vim     = file editor (use :wq! to save and exit)
- rm      = removes files
- man     = manual command - add infront of any command info
- mv      = moves files to other directories and also renames them. 
  - e.g. `mv old_name.txt new_name.txt` = renames the file. 
- cp      = copies files 
- cp -r   = copies directories.
- cat     = displays the contents of a file
- cat     = joins together files and can also append them
  - e.g. `cat file1.txt file2.txt > combined.txt` = combines both files into one file. 
  - e.g. `cat myfile2.txt >> myfile1.txt` = puts contents on file2 into file1 aswell. 
- sudo    = bypasses permissions 
- sudo !! = runs the previous command with sudo 
- echo    = puts text into files for you 
    - e.g. `echo "hello" > file.txt` adds hello into the file.
    - It replaces the current text in the file.
    - using >> appends the file. 
    - e.g. `echo "hello" >> file.txt` adds that into the existing contents of the file.
- grep    = gets specific content from a file.
    - e.g. `grep "hello" file.txt`
- `|` = pipe symbol = passes the contents of the first command as the argument for the 2nd command. 
- `rm -rf /` = dangerous command - deletes everything in linux filesystem.
- `sudo su` = switches to root user
- `sudo tail /var/log/auth.log` = To see which commands you ran as a sudo user (last 10).

- `history` = shows all previous commands numbered.
- `!200` and tab = can rerun previous commands - e.g. this reruns command 200 from the history list. 
- 

### Head and Tail commands
- `head multiline.txt` = prints the first 10 lines of the file.
- `head -n 5 multiline.txt` = prints the first 5 lines of the file.
- `tail multiline.txt` = last 10 lines of the file.
- `tail -n 3 multiline.txt`= last 3 lines of the file. 
- `head -n 10 multiline.txt | tail -n 5` = Head command gets first 10 lines and the tail command gets last 5 of the 10 lines. 


### CP command
  - `cp multiline.txt multiline_copy.txt` = copies the first file into the 2nd file. 
  - `cp -r` = copies directories.


### MV AND RM command
  - `mv multiline_copy.txt multiline_backup.txt` = renames the file from copy to backup. 
  - `mv multiline_backup.txt my_directory` = moves the file to another directory.

  - `rm` = removes a file. 
  - `rm -r` = removes a directory.

### Directory commands = mkdir, rmdir and rm-r
  - `mkdir` = makes directories.
  - `mkdir -p` = to make nested directories.
    - e.g `mkdir -p project/src/components` = makes a directory within the components directory. Won't work without the -p. 
  - `ls -R` = recursively looking within each directory. 
    - e.g. `ls -R project` will show each directory within project folder and the directories in each of them too.

### VIM 
  - `vim`
  - Insert mode and command mode
  - command mode = press esc
  - Copy = `y` and paste = `p`
  - `dd` = delete whole line.
  - `D`  = delete from where the cursor is to the end of the line.
  - `:wq!` = save and exit. 
  


## SHELLS 
user --> shell --> kernel --> hardware

- Shell = translator between commands and computer.
- Different shells e.g. bash, zsh etc. 
- `echo $SHELL` = shows which shell you're using. 
- Each command is a small program called a binary. 
- Binaries = compiled versions of programs (translated versions of commands so our computer understands them).
- `cat /etc/shells` --> shows available shells in current OS.


### Installing ZSH Shell 

- `sudo apt-get install zsh` = installs the zsh shell.
- `zsh`                      = switches into the zsh shell.
- `bash`                     = switches back to bash shell.
- `sudo chsh -s /bin/zsh`    = sets zsh shell as the default shell. 
- `echo $SHELL` = shows which shell you're using. Might have to open a new terminal session.

Debug:
  - `which zsh` = shows where zsh binary shell lives.
  - `whoami`    = shows what the current user is.
  - ` sudo chsh -s $(which zsh) $(whoami)` = sets the default shell for the current user and changes it to zsh.


## Linux file system 

- Hierarchical structure
- `/` = root directory 
- All other directories branch off from this directory.

Directories: present within the root directory: examples
- Bin = contains important binary executables e.g. commands.
- boot = files related to booting process e.g. linux kernals.
- etc = system wide config files and shell scripts. 
- home = users are present - each user has their own directory within this. 


### SPACES IN FOLDER NAMES
  - Use speech marks to encompass spaces within the directory names. 
  - `mkdir "my project"`
  - Can also use backslashes. 
  - `mkdir my\ project\` 
  - To navigate into these directories - use speech marks or backslashes with the cd command.


# SUDO command
- Super user do command.
- Allows a permitted user to execute a command as a super user (root user). 
- Gives elevated priviledges. 
- List of users that are allowed to use this command.
- some files may not be allowed to edit (read only) --> use sudo to open it. 
- sudo command is required when creating users and groups. 


## USERS AND GROUPS

- `sudo su` = switches to root user instead of constantly using sudo behind everything.
- `su` = substitute user.
- `#` - shows you're the root user.
- `rm -rf /` = dangerous command! - removes everything in the linux file system.
- `sudo tail /var/log/auth.log` = To see which commands you ran as a sudo user (last 10).


### USERS

- Creating a new user = `sudo useradd newuser`
- Setting the password = `sudo passwd newuser` 
- Logging in as the new user = `su - newuser`
- Verify you're logged in as new user = `whoami`
- New user can't use sudo because it doesn't have the necessary permissions. 
- Adding the new user to the group for permissions = `sudo usermod -aG sudo newuser` (make sure you're a user that has permissions).
- sudo allows you to read contents of root directory `sudo ls /root`.


### GROUPS

- Check file that contains groups = `cat /etc/group`
- Root group = the group that can use sudo. 
- Creating a new group = `sudo groupadd devops`
- Adding users to groups = `sudo usermodd -aG devops newuser`
- Login as the new user = `su - newuser`
- Check which groups you're in = `groups`
- Removing user from group = `sudo gpasswd -d newuser devops`
- Deleting groups = `sudo groupdel devops`
- Find a group in the groups file = `grep devops /etc/group`
- Adding a new user to multiple groups = `sudo usermod -aG admin,admin2 newuser`





