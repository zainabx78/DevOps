# Security Group and Cloud Networking basics

## Security Groups

- Security groups = stateful 
  - If inbound traffic is allowed , the same outbound traffic will be allowed too - vice versa. 

- Security groups act as a firewall on EC2 instances. 

- Outbound traffic all allowed by default. 
- All inbound traffic is blocked by default. 

- Regional - they can't be used from one region to another. 

- Can be attached to multiple instances. 

- Referencing other security groups:
  -  If IPs are constantly change, this helps with managing that. 
  
- E.g. :

```
Type	Port	Source
Custom TCP	6379	app-sg
```

  - Allow port 6379 (Redis’s door) only from servers that are wearing app-sg. Nothing else can reach Redis.

  - IPs change. Servers get new addresses when they restart or are replaced. With IP rules, you’d have to keep updating them.

  - Scaling just works. Remember running 3 Flask copies? If AWS adds 5 more Flask servers, as long as they’re given app-sg, Redis lets them in automatically. No rule changes.

  - Easier to read. “Allow from app-sg” explains itself. “Allow from 10.0.3.47” doesn’t.


### A common real-world layout

- This chains together in layers:

  - web-sg (load balancer): allows port 443 from the internet.
  - app-sg (app servers): allows port 5000 only from web-sg.
  - db-sg (database): allows its port only from app-sg.


## Classic Ports to Know:

- 22 = SSH - Log into a linux instance. 

- 21 = FTP - upload files into a file share.

- 22 = SFTP - upload files using SSH.

- 80 = HTTP - access unsecured websites.

- 443 = HTTPS - access secured websites. 

- 53 = DNS - for DNS queries and resolving.

- 3389 = RDP - log into a windows instance. 


## NAT Gatway/ 
- Translate private IP addresses into public ones for private servers/networks to be able to access the internet. 


## Public vs Private IP

- Public IP = 
  - Machine can be identified on the internet.
  - Must be unique across the whole web. 
  - No 2 machines can have the same IP.
  - Can be geo-located easily. 

- Private IP = 
  - Machine can be identified on a private network only. 
  - Must be unique across the private network. 
  - 2 different private networks can have the same IP.
  - Machines connect to the internet using a NAT gateway and internet gateway. 
  - Only a specified range of IPs can be used as private IPs.


## Elastic IPs
- Public IPs are usually dynamic (keep changing).
- Elastic IP = IP that doesn't change and stays the same. 
  - Public IP that you own as long as you don't delete it. 
- Fixed IP for EC2s.
- You can attach it to 1 instance at a time. 
- Need to create a VM with no public IP address and then allocate the elastic IP to it. 
- AWS will charge for any elastic IP you're not using and it's just sitting there. 
- Can only use 5 elastic IPs in your AWS account. 

### When to use and not to use elastic IPs:

- You can mask the failure of a server by using elastic IP because you can rapidly remap the address to another instance that's healthy. 

AVOID WHEN:
- Often reflect poor architectural decisions. 
- Can instead use a random IP and register a DNS name to it. 
- Use a load balance instead and don't use a public IP. 