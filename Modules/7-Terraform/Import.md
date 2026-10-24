# Terraform import

- What if a resource already exists in the cloud, but wasn't created with Terraform?
    - Use import to bring it under Terraform management.
    - Useful for using Terraform with existing infrastructure.
    - Import does NOT create, change or delete anything. It just adds the resource to Terraform's records (the state file).
- Terraform documentation shows how to import each resource type (and what its ID looks like).

## Method 1: Import block (Terraform 1.5 and later, recommended)

```
import {
  to = aws_instance.web
  id = "i-0abc123def456789"
}
```

- `web` = the nickname Terraform uses in the code (any name you like).
- `id` = the real ID from AWS (EC2 → Instances → Instance ID).
- Run `terraform plan -generate-config-out=generated.tf` to have Terraform write the resource block for you.
- It contains the resource block describing your EC2.
- Run `terraform plan` to preview, then `terraform apply` to actually do the import.

## Method 2: Import command (older way)

- `terraform import aws_instance.testimport i-0abc123def456789`
- Must write the resource block yourself FIRST, or the command won't work:

```
resource "aws_instance" "testimport" {
  # settings must match the real instance
}
```

- Import happens immediately when the command runs.

## After importing: check the plan

- Run `terraform plan`. Goal: **0 to add, 0 to change, 0 to destroy.**
- If the code doesn't match the real resource, Terraform will want to:
    - **change** it to match the code, or
    - **destroy and recreate** it (for some settings).
- Fix the code until the plan shows no changes. Never apply a plan you haven't read.
- E.g. if tags in console but not in terraform, terraform will try to make a change to them so they don't exist because they're not in the desired state. So, add the same tags in the console. 