# Bash to cloud-init

- **`#!/bin/bash` → `#cloud-config`**
  Tells the server what kind of instructions these are.

- **`yum update -y` → `package_update: true`**
  Refreshes the list of available software.

- **`yum upgrade -y` → `package_upgrade: true`**
  Upgrades software that's already installed.

- **`yum install nginx -y` → `packages: - nginx`**
  Installs NGINX.

- **`systemctl start nginx` / `systemctl enable nginx` → `runcmd:`**
  Runs these commands at the end, after everything else is installed.

- **`echo "Script Complete"` → `final_message:`**
  Prints a message to the log when everything's done.



**Why cloud-init instead of a bash script:**
- Describes *what* to set up, not the exact commands, so the same file works across different Linux types.
- No `sudo` or `-y` flags needed.
- Runs in a fixed order (update → install → commands), so services always start after they're installed.
- Easier to read, with its own dedicated file.


**Rules to remember:**
- `#cloud-config` must be the very first line.
- Use spaces for indentation, never tabs.
- Save with LF line endings, not CRLF (important on Windows).
