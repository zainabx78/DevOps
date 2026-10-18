# 6 - AWS

Notes and hands-on projects for building and running infrastructure on Amazon Web Services.

## Contents

| # | Topic | What it covers |
|---|-------|----------------|
| 1 | [AWS Intro](Intro.md) | What AWS is, regions, availability zones and the free tier |
| 2 | [IAM](IAM.md) | Users, groups, roles and policies for controlling access |
| 3 | [Compute](Compute.md) | Running servers with EC2, instance types and key pairs |
| 4 | [Storage](Storage.md) | S3 buckets, EBS volumes and choosing the right storage |
| 5 | [Networking](Networking.md) | VPCs, subnets, route tables and internet gateways |
| 6 | [Security + Networking](Security%20+%20Networking.md) | Security groups, NACLs and keeping resources protected |
| 7 | [Load Balancing + Scaling](LoadBalancing+Scaling.md) | Spreading traffic with load balancers and scaling automatically |
| 8 | [DNS](DNS.md) | Managing domains and routing traffic with Route 53 |
| 9 | [CloudFront](Cloudfront.md) | Delivering content faster with AWS's CDN |
| 10 | [Docker on AWS](Docker.md) | Running containers on AWS with ECR and ECS |
| 11 | [Serverless](Serverless.md) | Running code without managing servers using Lambda and API Gateway |

## Projects

| # | Project | What it covers |
|---|---------|----------------|
| 1 | [EC2 Web Server](PROJECTS/EC2-webserver.md) | Launching an EC2 instance and hosting a web page |
| 2 | [VPC + Networking](PROJECTS/1-VPC+Networking.md) | Building a custom VPC with public and private subnets |
| 3 | [Application Load Balancer](PROJECTS/2-ALB.md) | Putting a load balancer in front of multiple servers |
| 4 | [S3+Cloudfront](PROJECTS/3-S3-Cloudfront-DNS.md) | Hosting a static website on S3 and serving it through CloudFront (uses `index.html` and `error.html`) |
| 5 | [Serverless API](PROJECTS/4-ServerlessAPI-Lambda.md) | Building an API with Lambda and API Gateway |

## Key Takeaways

- Give users and services only the permissions they need (least privilege).
- Never use the root account for everyday work, and turn on MFA.
- Put public-facing resources in public subnets and keep databases in private subnets.
- Security groups control traffic to instances and NACLs control traffic to subnets.
- Use load balancers and auto scaling to keep apps available when traffic changes.
- Use CloudFront in front of S3 for faster, more secure static sites.
- Shut down or delete resources when you're done to avoid surprise bills.

[⬅ Back to main page](../../README.md)