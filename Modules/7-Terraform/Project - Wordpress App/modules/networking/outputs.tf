output "vpc-id" {
  value = aws_vpc.my-vpc
}

output "public-subnet-id" {
  value = aws_subnet.public-subnet.id
}

output "public-subnet-id-2" {
  value = aws_subnet.public-subnet-2.id
}


output "private-subnet-id" {
  value = aws_subnet.private-subnet.id
}

