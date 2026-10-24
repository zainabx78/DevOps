
# right now, there’s no way into your EC2, and your WordPress admin password is locked inside it.

# When app script ran, it made up a random password for the WordPress admin account (WP_PASS=$(openssl rand -hex 8)) 
# and saved it only in a file on the EC2. 
# Without that password, you can’t log into /wp-admin, which is where you write posts, change themes, and manage the site.

# Normally you’d log into a server with SSH, but this EC2 has no public IP (it’s in the private subnet). 
# It has no SSH key, and its security group only allows traffic from the ALB. 
# That’s what makes it secure, but it also locks you out.

# Session Manager is AWS’s way around this. 
#It lets you open a terminal on the EC2 from the AWS console, with no SSH, no open ports, and no keys. 
# It just needs an IAM role on the EC2, which is AWS’s way of giving it permission to talk to Session Manager. 
# That’s what the SSM Agent unable to acquire credentials line in the log was complaining about. 
# Errors in the system logs before these permissions were added






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