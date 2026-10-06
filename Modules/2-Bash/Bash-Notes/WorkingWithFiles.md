# Working With Files

## Reading files:

- Example - script opens a text file and showes everything inside it on the screen, one line at a time. 
  
```bash
#!/bin/bash

read_file(){
    local file_path="$1" 
    # first parameter entered in terminal
    # Local variable = only available inside this script.

    while IFS= read -r line
    do 
        echo "$line"
    done < "$file_path"
}

read_file "./log.txt"


```

- Local variable = only available inside this script.

- `while IFS= read -r line `
  - This starts a loop that says: "Keep reading the file one line at a time, and each time, put that line into a box called line." 
  - The extra bits (IFS= and -r) just make sure the line is read exactly as written, without trimming spaces or changing special characters.

- `-r` = prevents \ from being interpreted as escape characters.

- `done < "$file_path"` 
  - This marks the end of the loop. The < "$file_path" part tells the loop which file to read from, the one whose name we stored earlier.


## Using Cat command to read files:

- Same as previous example but just using cat.

```bash 
#!/bin/bash

process_file(){
    local file_path="$1"

    cat "$file_path | while IFS= read -r line; then
        echo "Processing line: $line"
    done
}

processing_file "./log.txt"

```

## Writing files:

- Creating a new file and writing data using redirection
- This means using `>` or `>>`.

```bash
#!/bin/bash

write_file(){
    local file_path="$1"
    local data="$2"

    echo "$data" > "$file_path"
}

write_file "read.txt" "Hello World"

```
  - This script redirects the second parameter into the first parameter given when calling the function.
  - `>` = rewrites the whole file/writes it to a new file if doesn't exist.
  - `>>` = appends the file. 



## File Checksums

- Cryptographic hashes that provide a unique fingerprint for a file. 
- This allows us to verify the authenticity of a file. 
- Every file has a file checksum that's different to another file. 


### Use the `md5sum` command

- It will show a long string of letters and numbers, a kind of "fingerprint" for the file. If the file changes even slightly, the fingerprint changes too, which is why people use it to check that a download wasn't corrupted.
- Need to install it. 
- Use `md5sum --version` to verify if it's installed or not.
- If not installed, use `sudo apt install coreutils` to install it (ubuntu).


```bash
#!/bin/bash

calculate_md5sum(){
    local file_path="$1"
    md5sum "$file_path"

}

calculate_md5sum "read.txt"

```



### Use the `sha256` command

- Also need to install it. 
- Also generates a checksum.

  
```bash
#!/bin/bash

calculate_sha256sum(){
    local file_path="$1"
    sha256sum "$file_path"

}

calculate_sha256sum "read.txt"

```

### Comparing checksums

```bash
#!/bin/bash

compare_checksums() {
    local checksum1="$1"
    local checksum2="$2"

    if [[ "$checksum1" == "$checksum2" ]]; then 
        echo "checksums match. File is intact"
    else
        echo "checksums do not match. File integrity compromised" 
    fi
}

compare_checksums "123" "1234"
# Enter the actual checksums here. 

```
