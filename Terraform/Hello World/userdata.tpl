######### Simple bash script to configure the hello world configuration on the EC2 instance on start up.

#!/bin/bash
# Update the system
yum update -y

# Install Apache web server (httpd)
yum install -y httpd

# Start the Apache web server
systemctl start httpd

# Enable Apache to start on boot
systemctl enable httpd

# Create a simple HTML file for the "Hello World" webpage
echo "<html>
  <head><title>Hello World</title></head>
  <body><h1>Hello World from EC2!</h1></body>
</html>" > /var/www/html/index.html

# Restart Apache to ensure the page is available
systemctl restart httpd
