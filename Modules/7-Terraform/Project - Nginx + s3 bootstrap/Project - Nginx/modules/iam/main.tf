
# The role: a set of permissions the EC2 can use
resource "aws_iam_role" "ec2-ssm-role" {
  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Give the role Session Manager permissions
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2-ssm-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# The "holder" that attaches the role to an EC2
resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ec2-ssm-role.name
}