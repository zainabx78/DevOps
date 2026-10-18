# Running a webserver on an EC2 instance

1. Create an EC2 instance

   - Name: `Zainab First Instance`
   - Image: Amazon linux AMI. 
   - Instance type: t2.micro
   - Create key pair - ppk - windows.
   - Networking - defaults. (Public IP and Allow SSH and HTTP).
   - Userdata: 

```
#!bin/bash

yum update -y 
yum install -y httpd

systemctl start httpd
systemctl enable httpd

echo "<h1>Hello, I'm Zainab from $(hostname-f)</h1>" > /var/www/html/index.html


```


2. Access the webserver:

- URL = `http: publicIP`
- It'll show you the private ip. Because $hostname shows internal address. 

- If the server gets refreshed (stopped and restarted) - it gets assigned to a different public IP address. Use the new IP to access it. 



