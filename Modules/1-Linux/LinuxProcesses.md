## Processes- 

- User processes (`ps`)
- Sytem processes (`ps -e`)
- **`ps -aux`** - detailed process overview.
- `top`- Refreshes every 3 seconds- real-time.
  - Orders the processes.
  - Top of the list is ranked by amount of cpu being used.
  - SHIFT + N = most memory
  - SHIFT + P = most cpu

`sleep 3` - makes your terminal sleep for 3 seconds. 
`sleep 5000 &` - Runs command in the background.
  - `jobs` - You can see the processes running in the background.
  - `jobs -l` - shows ID too.
  
`sudo systemctl status nginx` - Checks status of the process nginx.
`stop nginx` - Stops the process. 

### To stop processes:
  - `kill` - Different levels.
  - **The gentlest**= `kill -1 2990`
    - 2990= process ID (find by using `jobs -l).
    - Called a hang up.
  - **Medium level**= `kill -15`
    - Terminate.
    - Graceful- Terminates any child processes first and then kills any parent processes.
    - It's the default so can also just put `kill` with process ID.
  - **Strongest level of kill**= `kill -9 <processID>` 
    - Harshest form of kill.
    - It will kill the parent process. The child processes will become zombie processes- they'll be left running in memory. Won't cause harm but needs manual clean up if dont need them. 
  
# View processes
ps aux
ps aux | grep nginx

# Real-time monitoring
top
htop  # install via: sudo apt install htop

# Background processes
sleep 100 &
jobs
fg %1  # bring to foreground
bg %1  # send to background

# Kill processes
kill <PID>
killall sleep

