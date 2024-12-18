########This script creates an ec2 in priv subnet and the ec2 
####has a hello world application deployed on it.
####The ec2 is accessible from the load balancer in a public subnet. 

resource "aws_vpc" "myvpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "test"
  }
}

resource "aws_subnet" "pubsub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "pubsub2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.123.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
}

resource "aws_subnet" "privsub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.123.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "privsub2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.123.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "pubrtb" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "privrtb" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route" "privroute" {
  route_table_id         = aws_route_table.privrtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.mynatgateway1.id
}

resource "aws_route" "route1" {
  route_table_id         = aws_route_table.pubrtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myigw.id
}

resource "aws_route_table_association" "privrtbassoc1" {
  subnet_id      = aws_subnet.privsub1.id
  route_table_id = aws_route_table.privrtb.id
}

resource "aws_route_table_association" "privrtbassoc2" {
  subnet_id      = aws_subnet.privsub2.id
  route_table_id = aws_route_table.privrtb.id
}


resource "aws_route_table_association" "myrtbAssoc1" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.pubrtb.id
}

resource "aws_route_table_association" "myrtbAssoc2" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.pubrtb.id
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "myvpcsg" {
  name        = "publicsg"
  description = "open to internet for web server"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "myec2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.myami.id
  key_name               = aws_key_pair.mykeypair.id
  subnet_id              = aws_subnet.privsub1.id
  vpc_security_group_ids = [aws_security_group.myvpcsg.id]
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }
}

resource "aws_eip" "myeip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "mynatgateway1" {
  subnet_id     = aws_subnet.pubsub1.id
  allocation_id = aws_eip.myeip.id
}

resource "aws_lb" "myalb" {
  name                       = "myalb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.myvpcsg.id]
  subnets                    = [aws_subnet.pubsub1.id, aws_subnet.pubsub2.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "mytargetgroup" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "my_target_group_attachment" {
  target_group_arn = aws_lb_target_group.mytargetgroup.arn
  target_id        = aws_instance.myec2.id
  port             = 80 # Port on which your application listens
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytargetgroup.arn
  }
}
