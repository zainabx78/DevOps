# This .tf file creates:
#     - ALB (alb, listener, target group, security group)
#     - EC2 app (app and security group)

# Creating a security group for the ALB
resource "aws_security_group" "alb-sg" {
  name   = "alb-sg"
  vpc_id = var.vpc-id.id
}

# Rules for the alb security group 
resource "aws_security_group_rule" "alb-ingress" {
    security_group_id = aws_security_group.alb-sg.id
    type = "ingress"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

# -1 means all protocols and 0 means all ports and cidr means to every address
resource "aws_security_group_rule" "alb-egress" {
    security_group_id = aws_security_group.alb-sg.id
    type = "egress"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

# Creating the ALB for the nginx app inbound traffic
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
  target_id        = aws_instance.nginx.id
  port             = 80
}


# =========================================================================================


# Creating a security group for the EC2 - http traffic from the alb
# Creating a security group for the EC2 - http traffic from the alb
resource "aws_security_group" "app-sg" {
  name   = "app-sg"
  vpc_id = var.vpc-id.id
}


resource "aws_security_group_rule" "app-ingress" {
  security_group_id = aws_security_group.app-sg.id

  from_port = 80
  to_port = 80
  protocol = "tcp"
  type = "ingress"

  source_security_group_id = aws_security_group.alb-sg.id

}

resource "aws_security_group_rule" "app-egress" {
  security_group_id = aws_security_group.app-sg.id

  from_port = 0
  to_port = 0
  protocol = "-1"
  type = "egress"

  cidr_blocks = ["0.0.0.0/0"]

}

# Creating an EC2 to run nginx on --> using USER DATA

# resource "aws_instance" "nginx" {
#   ami             = var.ami-id
#   instance_type   = var.instance_type
#   subnet_id       = var.priv-sub-id
#   iam_instance_profile = var.iam-role
#   vpc_security_group_ids = [aws_security_group.app-sg.id]


#   user_data = <<-EOF
#   #!/bin/bash

#   sudo yum update -y
#   sudo yum upgrade -y

#   sudo yum install nginx -y

#   sudo systemctl start nginx
#   sudo systemctl enable nginx

#   echo "Script Complete"

#   EOF

#   user_data_replace_on_change = true

#   # Stops Terraform rebuilding the server (and wiping WordPress)
#   # whenever Amazon releases a newer AMI.
#   lifecycle {
#     ignore_changes = [ami]
#   }

#   tags = {
#     Name = "nginx-app"
#   }
# }



# Creating an EC2 to run nginx on --> using CLOUD INIT FILE

resource "aws_instance" "nginx" {
  ami             = var.ami-id
  instance_type   = var.instance_type
  subnet_id       = var.priv-sub-id
  iam_instance_profile = var.iam-role
  vpc_security_group_ids = [aws_security_group.app-sg.id]


  user_data = file("${path.module}/cloud-init.yaml")
  user_data_replace_on_change = true

  # Stops Terraform rebuilding the server (and wiping WordPress)
  # whenever Amazon releases a newer AMI.
  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = "nginx-app"
  }
}