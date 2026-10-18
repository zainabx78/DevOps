# IAM 

## Groups
- Only contain users, not other groups. 
- Users don't HAVE to belong to a group, they can also belong to multiple groups. 


## Policies 

### IAM PERMISSION POLICIES:
  - Json document that outlines permissions for users or groups. 
  - Effect = allow or deny.
  - Action = list of actions this policy allows or denies. 
  - Principle = who the policy is applied to. 
  - Condition = conditions for when this policy is in effect. 

- Password policies:
  - SSO - single sign on.. 

- AWS’s rule is: an explicit deny always wins. 
  - So if any other policy attached to the user (or their group) says “deny” for something, the admin can’t do it, even with full admin rights.


## MFA 
- If password is stolen or hacked, the account is not compromised. 

- Virtual MFA devices: 
  - Google authentication
  - Microsoft authenticator etc.

- Universal 2nd factor (U2F) security key
  - Support for multiple root and iam using a single security key.



## Access to AWS

- AWS management console = protected by password + MFA.
- CLI = protected by access keys - key ID and actual key.
- SDK = for code - protected by access keys. 

Never share access keys!
- Best practice to rotate keys consistently. 


### AWS CLI
- Enables you to interact with the AWS services using commands in terminal. 
- Can develop scripts to manage resources. 
- Direct access to public APIs of AWS services.

  - Download AWS CLI from online. 
  - `aws --version` - should show version.
  - Create a CLI access key.  
  - `aws configure`
  - Provide access key ID and access key. 
  - Set region you're using. 
  - json output format. 
  - `aws sts get-caller-identity` - check you've logged in and have access. 
  - `aws iam list-users` - showa users. 

### AWS SDKS
- Language specific APIs - set of libraries. 
- Embed AWS services directly within your app. 


## IAM ROLES FOR SERVICES

- Some AWS services will need to perform actions on your behalf. 
- Need to assign permissions to AWS with IAM roles. 
- E.g. EC2 Instance roles. 


## IAM security tools

### IAM Credentials Report - Account level. 
  - A report that lists all your account's users and the status of their various credentials. 


### IAM access advisor - user level
  - Access advisor that shows the service permissions granted to a user and when those services were last accessed. 
  - Good if you want to revise policies.


## IAM Guidelines and Best Practices

- Don't use root account except for AWS account setup. 
- One physical user = 1 AWS user. 
- Assign users to groups and assign permissions to groups.
- Create a strong password policy. 
- Use and enforce the use of MFA.
- Create and use roles for giving permissions to AWS services.
- Audit permissions of your account using IAM credentials Report and access advisor. 
- Never share IAM users and access keys!