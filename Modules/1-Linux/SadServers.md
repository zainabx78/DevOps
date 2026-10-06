# Sad Servers 
Process command related.

1. Scenario - Saint John

   - Need to find that specific process: `lsof /var/log/bad.log`
   - Need to kill that process: `kill -9 593`
   - 593 is the process ID.

2. Scenario 2 - Saskatoon

   - Need to find IP address that appears the most in a file.
   - Use awk command --> pattern scanning and processing language that can perform operations on a text file. 
   - We're told the IP is at the beginning of each line. 
   - We can extract it from each line using awk.
 - First:
   - `awk '{print $1}' /home/admin/access.log`
   - This command returns the first field of each line - the IPs.
   - `$1` references the first field of each line.
  
- Second: 
  - Need to sort the input lines in order (same Ips next to eachother)
  - Use the same command as before as the input for the sort command.
  - `awk '{print $1}' /home/admin/access.log | sort`

- Third:
  - Use the `uniq` command
  - This reports/filters out repeated lines in a sorted file. 
  - `awk '{print $1}' /home/admin/access.log | sort | uniq -c`
  - `-c` = prefixes each output line with the number of times it appeared in the output. 

- 4th: 
  - Use `sort -n` = sorts it numerically so we can see which one appears the most. 
  - `awk '{print $1}' /home/admin/access.log | sort | uniq -c | sort -n `

- Final command: 
  - `awk '{print $1}' /home/admin/access.log | sort | uniq -c | sort -nr `
  - The `-nr` at the end means it sorts it numerically and in reverse order so the highest number is at the top not bottom. 
  - `awk '{print $1}' /home/admin/access.log | sort | uniq -c | sort -nr | head -1 `
  - The `head -1` at the end shows the first line only - which is the highest counted IP. 

![alt text](../Images/Sadserver.png)

But, we only need it to display the IP not the count: 

- `awk '{print $1}' /home/admin/access.log | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'`
- `awk '{print $2}'` = prints only the 2nd column (where the IP is).

  
