# HANDS ON GIT AND GITHUB PRACTICAL

## Connecting to Github Overview:

1. Link the local git repo to the remote Github repo. `git remote add origin <url>` 
   
2. Send your work to the cloud. `git push -u origin main`

3. Bring down changes from Github: `git pull`

4. SSH vs HTTPS

- SSH = secure, no password. 
- HTTPS = easy but asks for credentials. 

# ------------------------------------------------



## STEP 1 - Setting up Git and Github

- Log into Github.
- Make sure Git is downloaded locally - `git --version`. 


## Step 2- Configure our identity for Git.

- Every commit records who made it, and Git needs to know who you are to fill that in.
- Remember that a commit is a save with a message, a date, and an author. Git gets the author details from your settings.

- Configure Git:
  - `git config --global user.name "zainabx78"`
  - `git config --global user.email "Zainabfarooq001@gmail.com"`


## Step 3 - SSH Key

1. Generate a public and private key:
  - `ssh-keygen -t ed25519 -C "zainabfarooq001@gmail.com" -f ~/.ssh/coderco_key`

   - Skip the passphrase part. 
  
2. 2 files get generated = 
  - .pub file - coderco_key.pub
  - normal coderco_key file.
  - Public key (.pub) can be shared - it's public. 
  - Private key needs to be kept privately. 

3. Cat the public file and copy contents.
   
   - `cat ~/.ssh/coderco_key.pub`

4. Add the public key to Github

   - Go to settings in top right corner
   - Go to SSH and GPG keys
   - Create a new SSH key.
   - Paste in the public key contents (all of it)
  
e.g. looks like this:
`ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAcD4UOiqlNetJ1gUYNVorNV6mMr7hLqCTk1MuSLeUyW zainabfarooq001@gmail.com`


4. Git Verify Login

- `ssh-add ~/.ssh/coderco_key` - Tell git to use this private key.
- `ssh -T git@github.com` - SSH into it. 

- If any errors:
  - Make sure agent is running - `eval "$(ssh-agent -s)"`
  - Make sure git bash is using your private key `ssh-add ~/.ssh/coderco_key`
  - Add this key permenantly to git so don't have to keep doing this `printf "Host github.com\n  IdentityFile ~/.ssh/coderco_key\n" >> ~/.ssh/config`