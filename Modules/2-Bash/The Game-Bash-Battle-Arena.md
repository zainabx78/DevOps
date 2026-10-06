# The Game: Bash Battle Arena 🎮

## Game Structure

The games are level-based. You begin at level 1, and the difficulty increases as you go up the levels.

There is a Boss Battle every 5 levels designed to combine and reinforce the knowledge from the previous 5 levels.



### LEVEL 1

```bash
#!/bin/bash

mkdir ~/Arena
cd ~/Arena
touch warrior.txt mage.txt archer.txt
ls -R ~/Arena
cat ~/Arena/*

```


### LEVEL 2

```bash
#!/bin/bash

input=1

while [ $input -le 10 ]
do
    echo $input
    ((input++))
done

```

OR 


```bash
#!/bin/bash

for i in {1..10}
do
    echo $i
done

```


### LEVEL 3

```bash
#!/bin/bash

if [ -f C:\Users\zaina\OneDrive\Desktop\DevOps\Modules\hero.txt ]; then
    echo "Hero found!"
else
    echo "Hero missing!"
fi

```

### LEVEL 4

- Use cp for a quick copy from a single folder, and rsync when your files are spread across subfolders or you'll be repeating the backup.

```bash
#!/bin/bash

rsync -avm --include="*/" --include="*.txt" --exclude="*" /root /root/Backup


```

- -avm is really three separate settings squeezed together. You could also write them as -a -v -m. Here's what each letter means:

- a = archive. This copies everything properly, including files inside folders and subfolders, and it keeps details like the dates and permissions the same as the originals. It's the standard "copy it all faithfully" setting.

- v = verbose. This makes rsync show you each file as it copies it, so you can see what's happening. Without it, rsync works silently.

- m = skip empty folders. Because your command tells rsync to look inside every folder, it would otherwise recreate all your folders in the backup, even ones with no .txt files in them. The m stops it from making those empty folders, so your backup only contains folders that actually have .txt files.


### LEVEL 5

```bash
#!/bin/bash

# Creates a directory names 'Battlefield'
mkdir /root/Battlefield

# Inside Battlefield, create files named knight.txt, sorcerer.txt, and rogue.txt.
touch /root/Battlefield/knight.txt /root/Battlefield/sorcerer.txt /root/Battlefield/rogue.txt

# Check if knight.txt exists; if it does, move it to a new directory called Archive.
if [ -f /root/Battlefield/knight.txt ]; then
    cp /root/Battlefield/knight.txt /root/Archive
    echo "File copied"
else 
    echo "Does not exist"
fi 

#  List the contents of both Battlefield and Archive
ls -R /root/Battlefield
ls -R /root/Archive

```


### LEVEL 6

```bash
#!/bin/bash

file_name(){
    echo "Please enter a file name: "
    read -r name
    lines=$(wc -l < "$name")

    if [ -f "$name" ]; then
        echo "Number of lines: $lines"
    else
        echo "No file provided/file doesn't exist"
        exit 1
    fi
}

file_name
```
- Another way:

```bash

#!/bin/bash

if [ -z "$1" ]; then
    echo "No file provided"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "File not found!"
    exit 1
fi

LINE_COUNT=$(wc -l < "$1")
echo "The file '$1' has $LINE_COUNT lines."


```


### LEVEL 7

```bash
#!/bin/bash

sort_file(){
    ls -lSr *.txt
    # ls = lists all files
    # -l = shows details
    # -S = sorts by size (biggest first)
    # -r = reverses the order so smallest first
    # *.txt = only includes .txt files.
}

sort_file

```

Another way: 

```bash
#!/bin/bash

DIRECTORY="Arena"

if [ ! -d "$DIRECTORY" ]; then
    echo "Directory does not exist."
    exit 1
fi

find "$DIRECTORY" -type f -name "*.txt" -exec ls -lh {} + | sort -k 5,5 -h | awk '{ print $5, $9 }'

```


### LEVEL 8

```bash
#!/bin/bash

searcher (){
    echo "Please enter the word you want to search: "
    read word

    search=$(grep -l "$word" *.log)
    # -l tells grep to only list the file names

    if [ -z "$search" ]; then
        echo "No files contain $word"
    else
        echo "Here are the files containing $word : $search"
    fi
    # -z asks 'is this empty?' e.g. do no files have that word?
}

searcher
```


### LEVEL 9

- Install inotify --> `apt install inotify-tools`
- inotifywait watches a folder and reports whenever something changes in it.
  
```bash
#!/bin/bash

#!/bin/bash

dir="/root/watched"
logfile="/root/changes.log"

echo "Watching $dir for changes... (press Ctrl+C to stop)"

inotifywait -m -e create -e modify -e delete \
    --timefmt '%Y-%m-%d %H:%M:%S' \
    --format '%T %e %f' \
    "$dir" >> "$logfile"

```

- What each part does:

  - `-m` keeps watching forever (monitor mode). Without it, it would stop after the first change.
  - `-e create -e modify -e delete` sets the three kinds of changes to watch for.
- `--timefmt` sets the timestamp style, like 2026-10-05 14:30:12.
--format '%T %e %f' controls what each log line contains: %T is the time, %e is the type of change, and %f is the file name.
>> "$logfile" adds each change to the end of the log file. A single > would wipe the file each time, so >> is important here.
The \ at the end of a line just means "this command continues on the next line."


### LEVEL 10

```bash
#!/bin/bash

#!/bin/bash

for i in 1 2 3 4 5; do
    file="file$i.txt" # Creates 5 files
    lines=$(shuf -i 10-20 -n 1) # Creates random number
    # shuf picks things at random.
    # -i 10-20 sets the range of numbers to choose from, 10 to 20.
    # -n 1 means pick just one number.


    # seq 1 $lines counts from 1 up to the random number.
    for n in $(seq 1 $lines); do
        echo "This is line $n" >> "$file"
    done

    echo "Created $file with $lines lines"
done

```



### LEVEL 11

```bash
#!/bin/bash

dir="$1"
threshold="$2"

usage=$(df --output=pcent "$dir" | tail -1 | tr -d ' %')

echo "Disk usage for $dir is $usage%"

if [ "$usage" -gt "$threshold" ]; then
    echo "ALERT: Disk usage is above $threshold%!"
    echo "$(date) - ALERT: $dir is at $usage% (limit $threshold%)" >> /root/disk_alerts.log
else
    echo "All good, usage is below $threshold%."
fi


# df stands for "disk free." It reports how much space is used on a disk. Normally it shows a big table with lots of columns, but --output=pcent tells it to show only the percentage used. 
# That percentage has an unnecessary `use%` infront of it.
# tail shows the end of some text, and -1 means "just the last 1 line." This throws away the heading `use%`.
# tr changes or removes characters, and -d means delete. The ' %' lists the characters to delete: a space and a percent sign.



```

- To run it - input the 2 parameters `./diskcheck.sh /root 80`




### LEVEL 12

```bash
#!/bin/bash

file="$1"

while IFS='=' read -r key value; do

    # Skip empty lines and comment lines starting with #
    if [ -z "$key" ] || [[ "$key" == \#* ]]; then
        continue
    fi

    echo "Key: $key  |  Value: $value"
done < "$file"

# IFS='=' tells bash to split each line at the = sign. IFS is short for "Internal Field Separator," which just means "the character to split on." Normally bash splits on spaces.

# read -r key value puts the part before the = into key and the part after it into value. The -r keeps any backslashes in the line from being treated as special characters.

# [[ "$key" == \#* ]] catches lines starting with #, which are usually comments. The \ before # stops bash from treating the rest as a comment in the script itself.

# || means "or", so the line is skipped if either check is true.

```




### LEVEL 13

```bash
#!/bin/bash

backup(){

    #Adding -p fixes that: it means "create it if it's missing, otherwise don't worry.
    mkdir -p /root/backup

    # date +%s gives the current time as one big number (seconds since 1970), like backup_1759674612
    cp -r /root/arena /root/backup/backup_$(date +%s)

    # ls -t lists the backups, newest first.
    # tail -n +6 keeps only the 6th one onwards, which are the old ones.
    # xargs rm -rf deletes them. xargs takes that list and hands it to rm as the things to delete.
    cd /root/backup && ls -t | tail -n +6 | xargs rm -rf
}

backup

```


### LEVEL 14

```bash
#!/bin/bash

menu(){
    echo "Please choose from one of these options:  check disk space, show system uptime, list users "
    read task

    if [ "$task" == "check disk space" ]; then 
        disk=$(df -h)
        echo "The disk space is: $disk"
    elif [ "$task" == "show system uptime" ]; then
        uptime=$(uptime -p)
        echo " The system uptime is: $uptime  "
    elif [ "$task" -eq "list users" ]; then
        users=$(who)
        echo "The list of user: $users "
    else
        echo "Sorry, That's not an option"
    fi

    # -eq is only for numbers. For comparing words, always use ==.
    
}

menu

```

- Another way: 
  
```bash
#!/bin/bash

menu(){
    echo "Please choose an option:"
    echo "1) Check disk space"
    echo "2) Show system uptime"
    echo "3) List users"
    read task

    if [ "$task" == "1" ]; then
        echo "The disk space is:"
        df -h
    elif [ "$task" == "2" ]; then
        echo "The system uptime is:"
        uptime -p
    elif [ "$task" == "3" ]; then
        echo "The list of users:"
        who
    else
        echo "Sorry, that's not an option"
    fi
}

menu
```

- Another way:

```bash

#!/bin/bash

echo "Choose an option:"
echo "1. Check disk space"
echo "2. Show system uptime"
echo "3. List users"

read -rp "Enter your choice [1-3]: " choice

case $choice in
    1) df -h ;;
    2) uptime ;;
    3) cut -d: -f1 /etc/passwd ;;
    *) echo "Invalid option" ;;
esac

```

### LEVEL 15

```bash
#!/bin/bash
# The line above tells the computer to run this script with bash

# Create a function called "menu" that holds everything below
menu(){

    # Show the menu options on screen
    echo "Please choose an option:"
    echo "1) Check disk space"
    echo "2) Show system uptime"
    echo "3) Backup the Arena directory"
    echo "4) Show settings from settings.conf"

    # Wait for the user to type a number, and save it in "task"
    read task

    # ---------- Option 1: Disk space ----------
    if [ "$task" == "1" ]; then
        echo "The disk space is:"
        # Show disk usage in an easy-to-read format (-h = human-readable, like 5G)
        df -h

    # ---------- Option 2: Uptime ----------
    elif [ "$task" == "2" ]; then
        echo "The system uptime is:"
        # Show how long the computer has been running (-p = pretty format)
        uptime -p

    # ---------- Option 3: Backup ----------
    elif [ "$task" == "3" ]; then
        # Create the backup folder if it doesn't already exist
        mkdir -p /root/backup

        # Copy the arena folder into a new backup, named with the current time
        cp -r /root/arena /root/backup/backup_$(date +%s)

        # Go into the backup folder, list backups newest first,
        # skip the newest 3, and delete the rest
        cd /root/backup && ls -t | tail -n +4 | xargs rm -rf

        # Show which backups are left
        echo "Backup done! Current backups:"
        ls /root/backup

    # ---------- Option 4: Read settings ----------
    elif [ "$task" == "4" ]; then
        # Read settings.conf one line at a time,
        # splitting each line at the "=" into "key" and "value"
        while IFS='=' read -r key value; do

            # Skip empty lines and lines starting with # (comments)
            if [ -z "$key" ] || [[ "$key" == \#* ]]; then
                continue
            fi

            # Print the setting
            echo "$key = $value"

        # Feed the settings.conf file into the loop
        done < /root/settings.conf

    # ---------- Anything else ----------
    else
        # The user typed something that isn't 1 to 4
        echo "Sorry, that's not an option"
    fi
}

# Run the menu function (without this line, nothing would happen)
menu

```