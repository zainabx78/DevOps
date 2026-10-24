# Assignment 1 – Deploy WordPress Using Terraform

## Objective

Use Terraform to deploy a full WordPress stack on AWS, including:

- An EC2 instance running WordPress
- Security groups
- User data to install dependencies
- A working public endpoint
- All resources provisioned via Terraform

This project shows how Terraform manages real infrastructure end to end.

---

## Architecture

![Architecture diagram](images/image.png)

- Visitors reach the site through an **Application Load Balancer (ALB)** in two public subnets.
- The ALB forwards traffic to a **WordPress EC2** in a **private subnet**, so the server is never exposed directly to the internet.
- The EC2 reaches the internet (for installs and updates) through a **NAT Gateway**.
- I access the EC2 for admin tasks through **AWS Systems Manager Session Manager**, with no SSH, keys, open ports or public IP.

---

## Project structure

```
Project - Wordpress App/
├── main.tf                  # Calls the modules and connects them
├── provider.tf              # AWS provider (region set once here)
├── variables.tf             # Root values (region, CIDRs, AMI, instance type)
├── .terraform.lock.hcl      # Locks provider versions
├── .gitignore
├── images/
└── modules/
    ├── networking/
    │   ├── vpc.tf           # VPC, subnets, gateways, route tables
    │   ├── variables.tf
    │   └── outputs.tf       # VPC ID and subnet IDs for the app module
    └── app/
        ├── ec2.tf           # EC2, ALB, listener, target group, security groups, user data
        ├── iam.tf           # IAM role for Session Manager
        ├── variables.tf
        └── outputs.tf       # ALB DNS name
```

---

## Modules

### Networking module

Sets up the underlying network:

- **VPC** – `10.0.0.0/16`
- **Subnets**
  - 2 public subnets in different Availability Zones (for the ALB and NAT Gateway)
  - 1 private subnet (for the EC2)
- **Internet Gateway** – lets internet traffic reach the ALB
- **NAT Gateway** (in a public subnet) – lets the private EC2 reach the internet for downloads and updates
- **Route tables**
  - Public route table (2 public subnets): sends internet-bound traffic to the Internet Gateway
  - Private route table (EC2 subnet): sends internet-bound traffic to the NAT Gateway

### App module

Everything that serves the app:

- **ALB** across the 2 public subnets
  - Security group: allows HTTP (port 80) from anywhere
  - **Listener** on port 80: forwards visitors to the target group
  - **Target group**: the list of servers the ALB sends traffic to, with a health check on `/`
- **EC2** in the private subnet
  - Security group: only allows HTTP (port 80) from the ALB's security group
  - User data installs Apache, PHP, MariaDB and WordPress on first boot
- **IAM (`iam.tf`)** – lets the EC2 use Session Manager:
  - **IAM role** (`ec2-ssm-role`) – can only be used by EC2 instances
  - **Policy** (`AmazonSSMManagedInstanceCore`) – AWS's ready-made Session Manager permissions. It can't touch any other AWS resources (least privilege).
  - **Instance profile** (`ec2-ssm-profile`) – the wrapper that attaches the role to the EC2, via `iam_instance_profile` in `ec2.tf`

### How the modules connect

Modules can't reference each other directly, so values pass through the root `main.tf`:

**networking `outputs.tf` → root `main.tf` → app `variables.tf`**

For example, the VPC ID and subnet IDs are output by the networking module and passed into the app module.

---

## What the user data script does

1. Installs Apache, PHP and MariaDB
2. Raises PHP's memory limit to 512 MB
3. Installs WP-CLI (the WordPress command-line tool)
4. Creates the database and a database user with a random password
5. Downloads and installs WordPress, using the ALB's address as the site URL
6. Installs the `_s` theme
7. Saves the admin login details to `/root/wordpress-login.txt`

> **Note:** the EC2 has `user_data_replace_on_change = true`. User data only runs on first boot, so this makes Terraform recreate the EC2 whenever the script changes, so the new version actually runs.

---

## How to deploy

```
terraform init
terraform plan
terraform apply
```

Wait 5–10 minutes for the user data script to finish, then visit the ALB's DNS name in a browser.

### Logging into WordPress

1. In the AWS console, go to the EC2 → **Connect** → **Session Manager** → **Connect**
2. Run:
   ```
   sudo cat /root/wordpress-login.txt
   ```
3. Go to `http://<alb-dns-name>/wp-admin` and log in with those details

---

## Troubleshooting walkthrough

### Step 1: Apache's placeholder page, but no WordPress

The ALB address showed Apache's default "It works!" page:

![Apache placeholder page](images/Apache.png)

Apache sends this page with a **403** status code ("nothing here"). The browser displays it anyway, but the ALB's health check sees the error code and marks the EC2 as **unhealthy**:

![Unhealthy target](images/targets.png)

This meant Apache was installed, but WordPress wasn't.

### Step 2: Checking the system log

To see what happened when the user data ran: **EC2 → Actions → Monitor and troubleshoot → Get system log**

![Getting the system log](images/syslogs.png)

The log showed the script stopped at this error:

```
PHP Fatal error: Allowed memory size of 134217728 bytes exhausted
```

PHP's default memory limit (128 MB) wasn't enough for WP-CLI to unzip WordPress. Because the script uses `set -e`, it stopped at that point.

**Fix:** raise PHP's memory limit in the user data, straight after installing PHP:

```
sed -i 's/^memory_limit = .*/memory_limit = 512M/' /etc/php.ini
```

### Step 3: The app is running

![WordPress site](images/app2.png)

![WordPress login page](images/login.png)

Login details, read through Session Manager:

![Login details](images/creds.png)

Logged into the WordPress dashboard:

![WordPress dashboard](images/SUCCESS.png)

The target group now shows the EC2 as **healthy**:

![Healthy target](images/HEALTH.png)

---

## Issues encountered and fixes

**1. Passing the whole VPC instead of its ID**
- *Error:* `Inappropriate value for attribute "vpc_id": string required, but have object.`
- *Cause:* The networking module's output returned the whole VPC resource instead of just its ID.
- *Fix:* Added `.id` to the outputs in `modules/networking/outputs.tf` (e.g. `aws_vpc.main.id`).

**2. Subnets outside the VPC's IP range**
- *Error:* `InvalidSubnet.Range: The CIDR '10.0.1.0/26' is invalid.`
- *Cause:* The VPC was `10.0.0.0/24`, which only covers `10.0.0.x`, so subnets starting `10.0.1` and `10.0.2` didn't fit inside it.
- *Fix:* Changed the VPC CIDR to `10.0.0.0/16`.

**3. Resources created in different regions**
- *Error:* `InvalidVpcID.NotFound` / `InvalidSubnetID.NotFound`, even though the VPC was created.
- *Cause:* Some resources had their own `region` argument, so they were built in a different region from everything else.
- *Fix:* Removed `region` from all resources and set it only once in the AWS provider (`region = var.region`).

**4. NAT Gateway can't find its Elastic IP**
- *Error:* `InvalidElasticIpID.NotFound: The elasticIp ID '...' does not exist.`
- *Cause:* Another symptom of issue 3: the Elastic IP and NAT Gateway were created in different regions.
- *Fix:* Same as issue 3.

**5. Availability Zone set as the region on subnets**
- *Error:* `lookup ec2.eu-west-1a.amazonaws.com: no such host`
- *Cause:* The subnets used `region` instead of `availability_zone`, so Terraform tried to contact a region called `eu-west-1a`, which doesn't exist.
- *Fix:* Changed `region` to `availability_zone` on each subnet.

**6. ALB subnets in the same Availability Zone**
- *Error:* `A load balancer cannot be attached to multiple subnets in the same Availability Zone.`
- *Cause:* No zone was set on the public subnets, so AWS placed both in the same one. An ALB needs at least two zones.
- *Fix:* Set `availability_zone` on each public subnet (`eu-west-1a` and `eu-west-1b`).

**7. AMI not found**
- *Error:* `InvalidAMIID.NotFound: The image id '[ami-...]' does not exist.`
- *Cause:* AMI IDs are different in every region. The ID was copied while the console was set to a different region from Terraform.
- *Fix:* Used the AMI ID for the correct region.

**8. Instance type not free tier eligible**
- *Cause:* `t2.micro` wasn't free tier eligible in my region.
- *Fix:* Listed the eligible types and switched to `t3.micro`:
  ```
  aws ec2 describe-instance-types --filters Name=free-tier-eligible,Values=true --query "InstanceTypes[*].InstanceType" --output text --region eu-west-1
  ```

**9. Security group ingress syntax**
- *Cause:* Wrote `ingress = [aws_security_group.alb-sg]`, but ingress is a block with ports and a source, not a list of resources.
- *Fix:* Used an `ingress { ... }` block with `security_groups = [aws_security_group.alb-sg.id]`.

**10. EC2 placed in a public subnet**
- *Symptom:* Target unhealthy; the system log showed the EC2 had an IP from the public subnet range (`10.0.2.x`).
- *Cause:* The wrong subnet ID was being passed to the EC2. In a public subnet without a public IP, the EC2 couldn't reach the internet to install anything.
- *Fix:* Passed the private subnet ID through the networking outputs and root `main.tf`.

**11. PHP out of memory during WordPress install**
- *Error:* `PHP Fatal error: Allowed memory size of 134217728 bytes exhausted`
- *Fix:* Raised PHP's memory limit to 512 MB in the user data (see the troubleshooting walkthrough).

**12. Site loaded without styling**
- *Symptom:* CSS and JavaScript failed to load; the browser was requesting `http://http/wp-content/...`.
- *Cause:* The `wp core install` line still used `$PUBLIC_IP`, which no longer existed, so WordPress saved its address as just `http://`.
- *Fix:* Used the ALB's DNS name (`$SITE_URL`) as the site address.

**13. GitHub rejected the push**
- *Error:* `File ... terraform-provider-aws ... is 809.75 MB; this exceeds GitHub's file size limit of 100.00 MB`
- *Cause:* The `.terraform` folder (Terraform's downloaded plugins) was committed before a `.gitignore` existed. The file was also first saved as `git.ignore` instead of `.gitignore`.
- *Fix:* Created a correctly named `.gitignore` (ignoring `.terraform/`, state files and `.tfvars`), undid the unpushed commit with `git reset --soft origin/main`, and recommitted.

---

## Lessons learned

- Each module has its own `variables.tf` (inputs) and `outputs.tf` (outputs); the root `main.tf` connects them.
- Modules can't reference each other directly; values pass through the root using `module.<name>.<output>`.
- `depends_on` is rarely needed, because Terraform works out the order from references.
- Set the region in one place (the provider). Region mismatches show up as confusing "does not exist" errors.
- A region (e.g. `eu-west-1`) is a whole AWS location; an Availability Zone (e.g. `eu-west-1a`) is a data centre inside it. Zones are set on subnets, and everything else follows the subnet it's placed in.
- A subnet's CIDR must fit inside the VPC's CIDR. A smaller number after the `/` means a bigger range.
- AMI IDs are per region, and load balancers need subnets in at least two Availability Zones.
- An Application Load Balancer can't have an Elastic IP (only a Network Load Balancer can).
- The system log (**Get system log**) shows what the user data script did, which is the first place to look when an EC2 isn't working.
- Session Manager gives secure access to a private EC2 with no SSH or open ports, using an IAM role.
- Always add a `.gitignore` before the first commit, and check `git status` before committing.

---

## Future improvements

- **Custom domain and HTTPS:** point `zainabf.co.uk` (Cloudflare) at the ALB, with an ACM certificate and an HTTP-to-HTTPS redirect.
- **Look up the AMI automatically** with `data "aws_ssm_parameter"`, so it works in any region.
- **Look up Availability Zones automatically** with `data "aws_availability_zones"`.
- **High availability:** run EC2s in two zones, with a NAT Gateway in each.
- **Separate database:** move MariaDB to Amazon RDS, so the data survives if the EC2 is replaced.