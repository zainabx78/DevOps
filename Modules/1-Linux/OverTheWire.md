# OverTheWire Bandit Notes

## Getting Started

**How to log in:** Each level is a new user. You log in with SSH, using the level number in the username and the password from the level before.

```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

**Explanation:**
- `bandit0` is the username. Change the number for each level.
- `-p 2220` tells it to use port 2220
- The first password is `bandit0`
- Type `exit` to leave a level before logging into the next one

---

## Bandit Level 0 → Level 1

**Challenge:** The password is stored in a file called `readme` in the home folder.

**Solution:**
```bash
ls
cat readme
```

**Explanation:**
- `ls` lists the files in the folder and shows the `readme` file
- `cat readme` prints what's inside the file

**Password:** 6y2kwnwK6grgvwvpvLaa2T1cpFEKOhNR

**What I learned:** `ls` shows what's in a folder and `cat` shows what's in a file.

---

## Bandit Level 1 → Level 2

**Challenge:** The password is in a file called `-` (just a dash).

**Solution:**
```bash
ssh bandit1@bandit.labs.overthewire.org -p 2220
ls
cat ./-
```

**Explanation:**
- `cat -` doesn't work because the system thinks the dash is a setting, not a file
- `./` means "in this folder", so `./-` tells the system it's a file

**Password:** PK8fYLZg2hnHSz83plBL1iEPKdD3QToB

**What I learned:** Putting `./` in front of a filename makes it clear it's a file, not a setting.

---

## Bandit Level 2 → Level 3

**Challenge:** The password is in a file called `--spaces in this filename--`. It starts with dashes and has spaces in it.

**Solution:**
```bash
ssh bandit2@bandit.labs.overthewire.org -p 2220
ls
cat ./"--spaces in this filename--"
```

**Explanation:**
- `./` stops the dashes at the start being read as a setting
- The quote marks keep the whole name together, so the spaces don't split it into separate words
- Tip: type `cat ./--sp` and press **Tab** to fill in the rest of the name

**Password:** 7ZZ2LFrykP2zEyvBl4m3clcL7tGYJPME

**What I learned:** Quote marks let you use filenames with spaces, and `./` still fixes the dash problem.

---

## Bandit Level 3 → Level 4

**Challenge:** The password is in a hidden file.

**Solution:**
```bash
ls
ls -la
cat ...Hiding-From-You
```

**Explanation:**
- `ls` on its own shows nothing, because hidden files start with a `.` and don't show up
- `ls -la` shows all files, including hidden ones
- `cat` then opens the hidden file

**Password:** xzTXq1rDJQVVAzdv5cHq1TQytTWufAMq

**What I learned:** Files starting with a dot are hidden, and `ls -la` reveals them.

---

## Bandit Level 4 → Level 5

**Challenge:** There are several files, but only one is human-readable. Find it.

**Solution:**
```bash
file ./*
cat ./-file07
```

**Explanation:**
- `file ./*` shows the type of every file in the folder
- All of them were "data" files except `-file07`, which was text
- `./` is needed again because the name starts with a `-`

**Password:** 6C7h9GD8M6ai5nr7wo1RonrzFjj9yIrG

**What I learned:** The `file` command tells you what kind of file something is, so you can spot the readable one.

---

## Bandit Level 5 → Level 6

**Challenge:** Find a file with these properties:
- Human-readable
- 1033 bytes in size
- Not executable

**Solution:**
```bash
find . -type f -size 1033c ! -executable -exec file {} \; | grep text
cat ./maybehere07/.file2
```

**Explanation:**
- `find . -type f -size 1033c` searches for files exactly 1033 bytes
- `! -executable` excludes executable files
- `-exec file {} \;` runs the `file` command on each result
- `grep text` filters for human-readable files
- Other ways that also work: `find -maxdepth 2 -type f -size 1033c` or `find -readable -size 1033c`

**Password:** pXa26xhMWaC2SvDotA4r9EgZkulOeSBW

**What I learned:** The `find` command is incredibly powerful for filtering files by multiple properties.

---

## Bandit Level 6 → Level 7

**Challenge:** Find a file somewhere on the whole system with these properties:
- Owned by user bandit7
- Owned by group bandit6
- 33 bytes in size

**Solution:**
```bash
find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null
cat /var/lib/dpkg/info/bandit7.password
```

**Explanation:**
- `find /` searches the whole system, starting from the very top folder
- `-user bandit7 -group bandit6` matches the owner and group
- `-size 33c` matches files exactly 33 bytes
- `2>/dev/null` hides the thousands of "Permission denied" errors, so only the real result shows

**Password:** Bmnnvf82KzQlfxgAI2d1zYbr1u9pr3E3

**What I learned:** `2>/dev/null` throws away error messages and keeps the screen clean.

---

## Bandit Level 7 → Level 8

**Challenge:** The password is in `data.txt`, next to the word "millionth".

**Solution:**
```bash
grep "millionth" data.txt
```

**Explanation:**
- `grep` searches inside a file and shows only the lines containing a word
- Another way: `cat data.txt | grep millionth`. The `|` passes the output of one command into the next.

**Password:** VR1ljMayciFxbnUokuQmJFw6QC9VKtub

**What I learned:** `grep` finds a word in a big file in seconds.

---

## Bandit Level 8 → Level 9

**Challenge:** The password is in `data.txt`. It's the only line that appears just once.

**Solution:**
```bash
sort data.txt | uniq -u
```

**Explanation:**
- `sort` puts matching lines next to each other
- `uniq -u` then keeps only the lines that aren't repeated
- Sorting first matters, because `uniq` only spots duplicates that sit side by side
- Another way: `sort data.txt | uniq -c | grep '^ *1 '` counts each line and shows the one with a count of 1

**Password:** EjmOSvuAu7sGAHqHVcBDPirRe9T03kxl

**What I learned:** Always `sort` before `uniq`, and the `|` lets you chain commands together.

---


## Bandit Level 9 → Level 10

**Challenge:** The password is in `data.txt`, next to several `=` signs. The file is mostly unreadable (binary) data.

**Solution:**
```bash
cat data.txt | grep -a ==========
```

**Explanation:**
- `data.txt` is a binary file, not a normal text file, so `grep` won't search it properly by default
- `-a` tells `grep` to treat the file as text anyway
- Searching for `==========` finds the lines with lots of equals signs, where the password sits
- Another way: `strings data.txt | grep ===` pulls out only the readable text first, then searches it

**Password:** B0s2khmbT9u0geKuOoVGW3JZKhndE3BG

**What I learned:** `grep -a` lets you search inside files that aren't normal text.

---

## Bandit Level 10 → Level 11

**Challenge:** The password is in `data.txt`, but it's encoded in base64.

**Solution:**
```bash
cat data.txt | base64 -d
```

**Explanation:**
- Base64 is a way of turning data into letters and numbers so it can be sent safely. It isn't encryption, so anyone can reverse it.
- `base64 -d` decodes it back to the original text

**Password:** pYfOY6HwUsDj5rL9UvyhU7MCmv8vN5Ro

**What I learned:** Base64 looks scrambled, but it's easy to decode, so it should never be used to hide secrets.

---

## Bandit Level 11 → Level 12

**Challenge:** The password is in `data.txt`, but every letter has been shifted 13 places along the alphabet (this is called ROT13).

**Solution:**
```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

**Explanation:**
- `tr` swaps one set of characters for another
- `'A-Za-z'` is the normal alphabet, in capitals and lowercase
- `'N-ZA-Mn-za-m'` is the alphabet shifted by 13, so A becomes N, B becomes O, and so on
- Doing the shift again undoes it, which reveals the password

**Password:** GROozWPO8QyN0mGrjUkID0WCYkZiQxrN

**What I learned:** `tr` can swap letters around, and ROT13 is a very simple code that's easy to reverse.

---

## Bandit Level 12 → Level 13

**Challenge:** The password is in `data.txt`, which is a hexdump of a file that has been compressed many times over. You need to keep undoing each layer until you reach the password.

**Solution:**
```bash
# Set up a working folder
cd /tmp
mktemp -d
cd /tmp/tmp.W5t1vua6G9          # your folder name will be different
cp ~/data.txt .
mv data.txt hexdump_data

# Turn the hexdump back into a real file
xxd -r hexdump_data compressed_data

# Layer 1: gzip
mv compressed_data compressed_data.gz
gzip -d compressed_data.gz

# Layer 2: bzip2
xxd compressed_data
mv compressed_data compressed_data.bz2
bzip2 -d compressed_data.bz2

# Layer 3: gzip
xxd compressed_data
mv compressed_data compressed_data.gz
gzip -d compressed_data.gz

# Layer 4: tar
mv compressed_data compressed_data.tar
tar -xf compressed_data.tar

# Layer 5: tar
tar -xf data5.bin

# Layer 6: bzip2
xxd data6.bin
bzip2 -d data6.bin

# Layer 7: tar
tar -xf data6.bin.out

# Layer 8: gzip
xxd data8.bin
mv data8.bin data8.gz
gzip -d data8.gz
cat data8
```

**Explanation:**
- `mktemp -d` makes a new folder with a random name in `/tmp`, so you have somewhere to work. You can't make changes in your home folder on this level.
- `cp ~/data.txt .` copies the file into the current folder. The `.` means "here".
- `xxd -r` reverses the hexdump and turns it back into the original file
- `xxd` on its own shows the start of a file, which tells you which type of compression it uses:
  - Starts with `1f 8b` = gzip
  - Starts with `BZh` = bzip2
  - Has filenames like `data5.bin` inside = tar
- `gzip -d` and `bzip2 -d` decompress the file. `tar -xf` extracts files from a tar archive.
- `gzip` needs the file to end in `.gz` before it will work, which is why you rename it first. The other commands don't strictly need the renaming.
- You keep checking, renaming and decompressing until `cat` finally shows readable text

**Password:** 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu

**What I learned:** Checking the first few bytes of a file with `xxd` tells you what type it really is, so you know which tool to use next. Patience matters, because some problems are just lots of small layers.



---

## Bandit Level 13 → Level 14

**Challenge:** There's no password for the next level. Instead, you're given a private SSH key that lets you log in as `bandit14`.

**Solution:**
```bash
ssh -i sshkey.private bandit14@localhost -p 2220
cat /etc/bandit_pass/bandit14
```

**Explanation:**
- `ssh -i` means "identity". It tells SSH to log in using a private key file instead of a password.
- The general format is: `ssh -i [key file] [username]@[server] -p [port]`
- `localhost` means "this same server". You're logging into `bandit14` from inside `bandit13`.
- Once you're in as `bandit14`, you can read its password from `/etc/bandit_pass/bandit14`
- **Note:** on the current version of the game, logging in to `localhost` from inside the server may be blocked. If it is, copy the key to your own computer and log in from there instead.

**Password:** 4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e

**What I learned:** You can log into a server with a private key instead of a password, using `ssh -i`.

**Useful links:**
- [OpenSSH Keys guide](https://help.ubuntu.com/community/SSH/OpenSSH/Keys)
- [Internet and Networking guide](https://help.ubuntu.com/community/InternetAndNetworking)

---

## Bandit Level 14 → Level 15

**Challenge:** Send the current password to port 30000 on the same server, and it will reply with the next password.

**Solution:**
```bash
telnet localhost 30000
```
Then paste in the current password and press Enter.

**Explanation:**
- `telnet` opens a simple text connection to a server on a specific port
- `localhost 30000` = connect to port 30000 on this server
- It works like a conversation. You send a message and the server sends one back.
- Another way: `nc localhost 30000` (netcat) does the same job

**Password:** BfMYroe26WYalil77FoDi9qh59eK5xNr

**What I learned:** Programs on a server listen on different ports, and `telnet` lets you talk to them directly.

---

## Bandit Level 15 → Level 16

**Challenge:** Same as the last level, but this time port 30001 only accepts encrypted (SSL) connections.

**Solution:**
```bash
openssl s_client -quiet -connect localhost:30001
```
Then paste in the current password and press Enter.

**Explanation:**
- SSL (now called TLS) creates an encrypted link between two computers, so nobody in between can read what's being sent
- It's what protects things like passwords and card details on websites. It's the padlock in your browser.
- `telnet` can't do encryption, so you use `openssl s_client` instead
- `-connect localhost:30001` = connect to port 30001 on this server
- `-quiet` hides all the extra connection details (certificates, session info) so the output is cleaner
- The "self signed certificate" message is just a warning and can be ignored here

**Password:** cluFn7wTiGryunymYOu4RcffSxQluehd

**What I learned:** `openssl s_client` lets you talk to servers that need an encrypted connection.

---

## Bandit Level 16 → Level 17

**Challenge:** Send the current password to one port between 31000 and 32000. You need to find which ports are open, which of those use SSL, and which one gives back the right answer.

**Solution:**
```bash
nmap -p 31000-32000 localhost
openssl s_client -quiet -connect localhost:31790
```
Then paste in the current password and press Enter.

**Explanation:**
- `nmap` scans ports to see which ones are open
- `-p 31000-32000` = only scan ports in that range
- Each port comes back as one of three states:
  - **Open** = something is listening and will reply
  - **Closed** = nothing is listening, so the connection is refused
  - **Filtered** = no reply at all, usually because a firewall is blocking it
- The open port that speaks SSL is the one to connect to with `openssl`
- Instead of a password, it sends back a **private SSH key**, which is used to log into the next level
- **Note:** the port numbers might be different when you play

**Password:** No password for this level. You get a private SSH key instead.

```text
-----BEGIN RSA PRIVATE KEY-----
[private key goes here]
-----END RSA PRIVATE KEY-----
```

**What I learned:** `nmap` shows which ports are open on a server, which is the first step in finding what's running on it.

---

## Bandit Level 17 → Level 18

**Challenge:** First, log in as `bandit17` using the private key from the last level. Then find the one line that's different between `passwords.old` and `passwords.new`.

**Solution:**
```bash
# Lock down the key file, then log in with it
chmod 600 bandit17.key
ssh -i bandit17.key bandit17@bandit.labs.overthewire.org -p 2220

# Compare the two files
diff passwords.new passwords.old
```

**Explanation:**
- After saving the key in a file, SSH refused to use it with the error `UNPROTECTED PRIVATE KEY FILE!`
- That's because the file had `644` permissions (`rw-r--r--`), which means other users could read it
- `chmod 600` changes it to `rw-------`, so **only you** can read and write it. SSH won't use a key unless it's locked down like this.
  - 6 = read (4) + write (2) for the owner
  - 0 = nothing for the group
  - 0 = nothing for everyone else
- `diff` compares two files and shows the lines that are different
- `<` shows the line from the first file (`passwords.new`), which is the new password
- `>` shows the line from the second file (`passwords.old`)

**Password:** kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd

**What I learned:** Private keys must have `600` permissions or SSH won't use them, and `diff` quickly spots changes between two files.

---

## Bandit Level 18 → Level 19

**Challenge:** The password is in a file called `readme`, but someone has changed `.bashrc` so you get logged out as soon as you log in.

**Solution:**
```bash
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
```

**Explanation:**
- `.bashrc` is a startup file that runs every time you log in. Here, it's been set up to kick you straight back out.
- Adding a command on the end of `ssh` (like `cat readme`) runs that command on the server **without** fully logging in, so `.bashrc` never kicks you out
- Another way: `ssh bandit18@bandit.labs.overthewire.org -p 2220 /bin/bash --norc` opens a shell that skips `.bashrc`, and then you can run `cat readme` yourself

**Password:** IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x

**What I learned:** You can run a single command on a remote server straight from `ssh`, and `.bashrc` controls what happens when you log in.

---

## Bandit Level 19 → Level 20

**Challenge:** There's a special program in the home folder called `bandit20-do`. Use it to read the next password.

**Solution:**
```bash
./bandit20-do
./bandit20-do whoami
./bandit20-do cat /etc/bandit_pass/bandit20
```

**Explanation:**
- Running `./bandit20-do` on its own shows that it runs a command **as another user**
- `./bandit20-do whoami` returns `bandit20`, which proves it's running as that user
- So `./bandit20-do cat /etc/bandit_pass/bandit20` can read a file that `bandit19` normally can't
- This works because it's a **setuid** program. Running `ls -l` on it shows an `s` where the `x` would normally be (`-rwsr-x---`), which means it runs with its owner's permissions, not yours.
- Running `./bandit20-do id` shows the difference:
  - `uid` = who you really are (`bandit19`)
  - `euid` = who you're acting as (`bandit20`). The "e" stands for effective.
- **UID** = user ID number. `0` is root, and normal users usually start from `1000`.
- **GID** = group ID number

**Password:** GbKksEFF4yrVs6il55v6gwY5aVje5f0j

**What I learned:** Setuid programs let you run something with another user's permissions. That's useful, but it's also a big security risk if it's set up carelessly.