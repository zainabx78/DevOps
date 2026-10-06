# Text Processing: grep, awk and sed

These three tools are used to search, pull out and change text. They're really useful for working with log files and command output.

- `grep` = **finds** lines that contain a word
- `awk` = **pulls out** specific columns from each line
- `sed` = **changes** or **picks out** parts of text

---

## grep: Searching for Text

### Basic search
```bash
grep "error" /var/log/syslog
```
- Searches the file `/var/log/syslog` and shows every line containing the word `error`
- `/var/log/syslog` is a system log file, where Linux records what's happening on the machine
- **Real use:** checking a server's logs when something has gone wrong

### Searching through every file in a folder
```bash
grep -r "TODO" ~/projects/
```
- `-r` = recursive, which means it searches every file in the folder **and** every folder inside it
- `~/projects/` = the projects folder in your home directory (`~` means home)
- It shows the file name and the line wherever `TODO` appears
- **Real use:** finding notes like "TODO" that developers leave in their code to mark unfinished work

### Counting results
```bash
grep -i "failed" /var/log/auth.log | wc -l
```
- `/var/log/auth.log` = the log file that records logins and `sudo` use
- `-i` = ignore case, so it matches `failed`, `Failed` and `FAILED`
- `|` = sends the results into the next command
- `wc -l` = word count, where `-l` counts **lines**. Each matching line is one result, so this gives you a total.
- **Real use:** a quick way to spot lots of failed logins, which could mean someone is trying to guess passwords

---

## awk: Pulling Out Columns

`awk` splits each line into columns (called **fields**). By default it splits them wherever there's a space.

- `$1` = the 1st column
- `$2` = the 2nd column, and so on

### Showing which user is running which program
```bash
ps aux | awk '{print $1, $11}'
```
- `ps aux` lists every running process, with lots of columns of info
- In that list, column 1 is the **user** and column 11 is the **command** being run
- `awk '{print $1, $11}'` prints only those two columns, so the output is much easier to read
- **Real use:** seeing which users are running what on a server

### Using a different separator
```bash
cat /etc/passwd | awk -F: '{print $1, $6}'
```
- `/etc/passwd` is the file that lists every user on the system. Its columns are separated by `:` instead of spaces.
- `-F:` tells `awk` to split columns on `:` instead
- Column 1 is the **username** and column 6 is their **home folder**
- **Real use:** getting a quick list of all users and where their files live

**Tip:** `awk -F: '{print $1, $6}' /etc/passwd` does exactly the same thing without `cat`, because `awk` can read files on its own.

---

## sed: Changing and Picking Out Text

### Find and replace
```bash
sed 's/old/new/g' file.txt
```
- `s` = substitute (replace)
- `old` = the text to find
- `new` = the text to replace it with
- `g` = global, which means replace **every** match on each line, not just the first one
- ⚠️ This only **shows** the changed text on screen. It doesn't change the actual file.
- To change the file itself, add `-i`: `sed -i 's/old/new/g' file.txt`
- **Real use:** updating a setting in a config file, like changing a server name or port number

### Printing certain lines
```bash
sed -n '10,20p' file.txt
```
- `-n` = don't print anything unless told to
- `10,20` = lines 10 to 20
- `p` = print
- So this shows **only** lines 10 to 20
- **Real use:** looking at one section of a huge log file without scrolling through all of it

---

## Piping Chains: Putting It All Together

```bash
cat /var/log/syslog | grep "error" | awk '{print $1, $2, $3}' | sort | uniq
```

Each `|` passes the result to the next command, like a production line:

1. `cat /var/log/syslog` = reads the system log
2. `grep "error"` = keeps only the lines with `error` in them
3. `awk '{print $1, $2, $3}'` = keeps only the first 3 columns, which are the **date and time** (for example `Oct 2 14:32:10`)
4. `sort` = puts them in order, so matching lines sit next to each other
5. `uniq` = removes duplicates, so each time only appears once

**Result:** a clean list of **when** errors happened, without all the extra detail.

**Real use:** working out when problems started on a server, which helps you track down what caused them.

**Note:** on some newer systems the log uses a different date format, with the full date and time all in column 1. If the output looks odd, try `awk '{print $1}'` instead.

---

## Quick Summary

| Command | What it does |
|---|---|
| `grep "word" file` | Finds lines containing a word |
| `grep -r` | Searches every file in a folder |
| `grep -i` | Ignores upper and lowercase |
| `wc -l` | Counts lines |
| `awk '{print $1}'` | Prints the 1st column |
| `awk -F:` | Splits columns on `:` instead of spaces |
| `sed 's/old/new/g'` | Replaces text |
| `sed -i` | Saves the change to the actual file |
| `sed -n '10,20p'` | Prints only lines 10 to 20 |
| `\|` | Sends the output of one command into the next |

**What I learned:** `grep`, `awk` and `sed` each do one small job, but chaining them together with `|` lets you dig through huge amounts of text really quickly.