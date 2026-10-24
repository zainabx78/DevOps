# Terraform Interview Questions

1. Cloud agnostic - across various cloud providers.
2. Idempotent - running multiple times wont break it. 
3. Infrastructure orchestration vs config management
4. Automation, consistency, repeatability. 
5. Enables version control, reduces manual intervention.
6. Terraform apply vs terraform plan. 
   - Terraform state - how plan makes the comparison between desired and actual state. Almost predicts the future. 

7. What is a tf provider? - plugin that allows terraform to interact with cloud providers. 
8. Role of state in terraform - state file - blueprint.




## Intermediate Qs

1. Purpose of a backend - remote vs local. 
    - Use cases.
    - Terraform locking


2. Terraform import vs terraform init
   - completely different. 
   - Import = brings existing infra under terraforms management.
     - Use cases etc. Manual deployments, no best practices. Import existing into tf. 
   - Init = initializes working directory, downloads required plugins, initializes any configured modules. 


3. How do you manage sensitive data in terraform - security.
   - Storing sensitive data in env variables. 


4. Utilising remote backend. 
   - E.g. S3 with secrets manager to store sensitive data. 


5. Terraform refresh 
   - updates terraform state file and syncs it with actual existing infrastructure. 


6. Modules 



## Behavioural questions

- E.g. which problems/blockers you experienced and how you solved it. 
- Screenshare! show the code and show them how you solved any problems. 


- Best practices 