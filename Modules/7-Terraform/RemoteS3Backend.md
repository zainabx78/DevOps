# S3 Remote backend configured:
   - Local boostrap - This is to create the s3 bucket before the remote backend can be configured.
     - It's an initial core solution that runs locally.
     - It provisions the resources terraform requires for remote state management.
  
   - Terraform’s state (its record of what it built) should be stored online so it’s safe and shareable. But the storage itself (an S3 bucket) has to be created first, and you want Terraform to create it. So it's done in two phases:

   1. Bootstrap: a small “core” project creates the S3 bucket, storing its own state on local computer for now.
   2. Move in: tell the core project to move its state into the bucket it just made. From then on, all your projects store their state there.

   HOW I DID IT:

   1. Created a new folder called bootstrap - Includes creation of s3 bucket for the backend. It also creates a file called backend.hcl which is created in my nginx project folder because that's where I need the backend configured.

   - The backend.hcl file: Can also create yourself. 
   ```go
   bucket       = "your-bucket-name"
   key          = "nginx/terraform.tfstate"
   region       = "us-east-1"
   use_lockfile = true

   ```
   
   2.  Run the bootstrap file. 
   ```go
   cd bootstrap
   terraform init
   terraform apply
   ```

   3. Tell my project to use that s3 bucket - Provider file:
   
   ```go
   terraform {
      backend "s3" {}
   }

   ```

   4. Move my state over to the s3 bucket:

   ```go
   cd "../Project - Nginx"
   terraform init -backend-config=backend.hcl -migrate-state

   terraform plan # should show no changes
   ```

![alt text](../../Images/s3backend.png)




## When you run terraform plan:

   - Terraform downloads the state file from S3.
   - It checks the real resources in AWS to see if anything changed outside Terraform (for example, someone deleting a server in the console).
   - It compares all of that with your code and shows the differences.

- The state file isn’t changed. plan only reads it.

- When you run terraform apply (or destroy):

  - Lock: Terraform puts a lock file in the bucket (from use_lockfile = true), so nobody else can run Terraform on this project at the same time.
  - Read: it downloads the current state.
  - Make changes: it creates, updates or deletes resources in AWS.
  - Save: it uploads the updated state back to S3, now including new details like server IDs and the ALB address.
  - Unlock: it removes the lock file.