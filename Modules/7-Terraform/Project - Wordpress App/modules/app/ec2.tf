# This .tf file creates:
#     - ALB (alb, listener, target group, security group)
#     - EC2 app (app and security group)

# Creating a security group for the ALB
resource "aws_security_group" "alb-sg" {
  name   = "alb-sg"
  vpc_id = var.vpc-id.id


  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Creating the ALB for the wordpress app inbound traffic
resource "aws_alb" "my-alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"

  subnets         = [var.pub-sub-id, var.pub-sub-id-2]
  security_groups = [aws_security_group.alb-sg.id]
}

# The listener watches for port 80 traffic
# When someone arrives, the listener follows it's rule:
# It's rule is the default_action
# The listener sends the visitor to the target group (type forward)
resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.my-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-target-group.arn
  }

}


# List of servers that can handle traffic
resource "aws_alb_target_group" "alb-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id.id

  health_check {
    path    = "/"
    matcher = "200-399"
  }
}

# Adds your EC2 to that list in the target group
resource "aws_alb_target_group_attachment" "ec2-attachment" {
  target_group_arn = aws_alb_target_group.alb-target-group.arn
  target_id        = aws_instance.wordpress.id
  port             = 80
}


# =========================================================================================


# Creating a security group for the EC2 - http traffic from the alb
# Creating a security group for the EC2 - http traffic from the alb
resource "aws_security_group" "app-sg" {
  name   = "app-sg"
  vpc_id = var.vpc-id.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Creating an EC2 to run wordpress on 

resource "aws_instance" "wordpress" {
  ami             = var.ami-id
  instance_type   = var.instance_type
  subnet_id       = var.priv-sub-id
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  vpc_security_group_ids = [aws_security_group.app-sg.id]

# Added the ALB dns name into this script so the app uses this address.
  user_data = <<-EOF
    #!/bin/bash
    set -e

    # ---- Settings you can change ----
    SITE_TITLE="My WordPress Site"
    WP_ADMIN="exampleuser"
    WP_EMAIL="user@example.org"
    DB_NAME="wordpress"
    DB_USER="wpuser"

    # ---- Random passwords (generated automatically) ----
    DB_PASS=$(openssl rand -hex 12)
    WP_PASS=$(openssl rand -hex 8)

    # ---- The ALB address (filled in by Terraform) ----
    SITE_URL="${aws_alb.my-alb.dns_name}"

    # ---- Install web server, PHP and database ----
    dnf update -y
    dnf install -y httpd php php-fpm php-mysqlnd php-gd php-mbstring php-xml mariadb105-server
    systemctl enable --now mariadb php-fpm httpd

    # ---- Give PHP more memory ----
    sed -i 's/^memory_limit = .*/memory_limit = 512M/' /etc/php.ini

    # ---- Install the WordPress command-line tool ----
    curl -sL -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x /usr/local/bin/wp

    # ---- Create the database ----
    mysql -e "CREATE DATABASE $DB_NAME;"
    mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
    mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost'; FLUSH PRIVILEGES;"

    # ---- Download and install WordPress ----
    cd /var/www/html
    wp core download --allow-root
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --allow-root
    wp core install --url="http://$SITE_URL" --title="$SITE_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_PASS" --admin_email="$WP_EMAIL" --allow-root

    # ---- Install the _s theme (optional, so it won't stop the script) ----
    wp theme install https://github.com/Automattic/_s/archive/master.zip --activate --allow-root || true

    # ---- Give the web server ownership of the files ----
    chown -R apache:apache /var/www/html
    systemctl restart httpd

    # ---- Save the login details somewhere safe ----
    echo "Site:     http://$SITE_URL/wp-admin" >  /root/wordpress-login.txt
    echo "Username: $WP_ADMIN"                 >> /root/wordpress-login.txt
    echo "Password: $WP_PASS"                  >> /root/wordpress-login.txt
    chmod 600 /root/wordpress-login.txt

    echo "End of Script : Complete"
  EOF

  user_data_replace_on_change = true

  # Stops Terraform rebuilding the server (and wiping WordPress)
  # whenever Amazon releases a newer AMI.
  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = "wordpress-server"
  }
}