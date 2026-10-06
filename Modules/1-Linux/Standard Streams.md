## Standard Streams

### Standard input
  - Provides input to the stream - e.g. typing something / typing a command and press enter.

### Standard Output
  - E.g. ls to list directories - printed on the screen as output.
  - Stream where commands send their output

  - Redirection = taking standard output away from the terminal
    - E.g. `echo "This is a test file" > output.txt`
    - This ensures the echo command sends the ouput to the file instead of the terminal. 

### Standard Error
  - Displayed on the terminal by default.
  - Error messages.

  - Redirecting the errors into a file:
    - `ls nonexistent 2> error.txt` 
    - This sends the error of the ls command, that's trying to open a file that doesn't exist, to the error file. 

  - `&>` = operator that is used for standard out and standard error (to put them both in one file)
    - E.g. `ls nonexistent my_directory &> all_outputs.txt`
    - This tries to list both nonexistent (a file that doesn't exist) and my_directory into a file called all_outputs.txt.
    - The file has both the error message and output of ls.


### DEV/NULL

- `/dev/null` is a file that discards anything written to it.
- E.g. `ls nonexistent 2> /dev/null` 
- Sends the error message into a file that deletes everything. That dev/null file has nothing in it even after the command. 