resource "aws_vpc" "MyVPC" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "PublicSubnet" {
  cidr_block                      = "10.123.1.0/24"
  availability_zone               = "us-east-1a"
  map_public_ip_on_launch = true
  vpc_id                          = aws_vpc.MyVPC.id
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mtc_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_association" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.mtc_public_rt.id
}


resource "aws_security_group" "MySG" {
  vpc_id      = aws_vpc.MyVPC.id
  name        = "MySG"
  description = "security group for a single ec2 for my labs"

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

resource "aws_key_pair" "mykey" {
  key_name = "id_rsa"
  public_key = file("C:/Users/zaina/.ssh/id_rsa.pub")

}
resource "aws_instance" "UbuntuEC2" {
  ami = data.aws_ami.MyAMI.id
  key_name = aws_key_pair.mykey.id
  subnet_id = aws_subnet.PublicSubnet.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.MySG.id ]
}
