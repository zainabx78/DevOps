# Terraform

Notes, practice code and projects from the Terraform module of my DevOps course.

Terraform is an Infrastructure as Code (IaC) tool. Instead of clicking through the AWS console, you describe the infrastructure you want in `.tf` files, and Terraform builds, updates and deletes it for you. The same code always produces the same setup, so it's repeatable, reviewable and easy to tear down.

---

## Folder Structure

```
7-Terraform/
├── Advanced/                          # Functions and techniques beyond the basics
│   ├── Coalesce.md
│   ├── Conditionals.md
│   ├── Count.md
│   ├── ForEach.md
│   └── merge.md
│
├── Project - Nginx + s3 bootstrap/    # NGINX on EC2 behind an ALB, with remote state in S3
│   ├── bootstrap/                     # Creates the S3 bucket for remote state
│   ├── Project - Nginx/               # The main NGINX project (modules, cloud-init)
│   └── README.md
│
├── Project - Wordpress App/           # WordPress stack on AWS
│
├── TerraformCode/                     # Practice code
│   ├── modules/ec2/
│   ├── import.tf
│   ├── main.tf
│   ├── provider.tf
│   └── terraform.tfvars
│
├── Images/                            # Screenshots used in the notes
│
├── Intro.md
├── Terraform.md
├── Variables.md
├── StateFiles.md
├── RemoteS3Backend.md
├── Modules.md
├── Import.md
├── cloudinit.md
└── InterviewQs.md
```

---

## Notes

Suggested reading order:

| File | Topic |
|---|---|
| [Intro.md](Intro.md) | What Terraform is and why it's used |
| [Terraform.md](Terraform.md) | Core concepts and the main commands |
| [Variables.md](Variables.md) | Variables, defaults, locals and tfvars files |
| [StateFiles.md](StateFiles.md) | What the state file is and how Terraform uses it |
| [RemoteS3Backend.md](RemoteS3Backend.md) | Storing state in S3, locking and the bootstrap pattern |
| [Modules.md](Modules.md) | Splitting code into reusable modules |
| [Import.md](Import.md) | Bringing existing AWS resources under Terraform |
| [cloudinit.md](cloudinit.md) | Configuring servers automatically on first boot |
| [InterviewQs.md](InterviewQs.md) | Interview questions and answers |

### Advanced

| File | Topic |
|---|---|
| [Conditionals.md](Advanced/Conditionals.md) | One-line if/else with `? :` |
| [Count.md](Advanced/Count.md) | Creating several copies of a resource, or none |
| [ForEach.md](Advanced/ForEach.md) | Creating resources from a list or map |
| [merge.md](Advanced/merge.md) | Combining sets of tags or settings |
| [Coalesce.md](Advanced/Coalesce.md) | Using the first value that isn't empty, as a fallback |

---

## Projects

### NGINX + S3 Bootstrap
An NGINX web server on EC2, reached through an Application Load Balancer.

- **Networking module:** VPC, subnets, gateways and route tables
- **App module:** EC2, ALB, target group, security groups, and cloud-init to install NGINX on boot
- **IAM module:** role for Session Manager, so the instance can be reached without SSH or open ports
- **Bootstrap:** a separate project that creates the S3 bucket for remote state, so the main project's state is stored safely online

See [the project README](Project%20-%20Nginx%20%2B%20s3%20bootstrap/README.md) for full details.

### WordPress App
A WordPress stack on AWS, provisioned entirely with Terraform.

---

## Quick Reference

### Main commands

| Command | What it does |
|---|---|
| `terraform init` | Sets up the project and downloads providers |
| `terraform plan` | Shows what will change, without changing anything |
| `terraform apply` | Builds or updates the infrastructure |
| `terraform destroy` | Deletes everything the project created |
| `terraform fmt` | Tidies the formatting of `.tf` files |
| `terraform validate` | Checks the code for errors |

### Key ideas

- **Provider:** the plugin that lets Terraform talk to a platform, such as AWS.
- **Resource:** something Terraform creates, such as an EC2 instance or S3 bucket.
- **Data source:** something Terraform reads but doesn't create.
- **Variable:** an input value, with an optional default.
- **Local:** a value worked out inside the code, to avoid repeating yourself.
- **Output:** a value shown after `apply`, such as the ALB address.
- **State:** Terraform's record of what it has built. Stored in S3 for real projects.
- **Module:** a folder of Terraform code that can be reused.

### Good habits

- Use defaults for most variables, and tfvars files only for values that change between environments (dev, staging, prod) or for secrets.
- Keep state remote (S3) with locking turned on.
- Never commit access keys, `*.tfstate` files or the `.terraform/` folder.
- Always read `terraform plan` before typing "yes".