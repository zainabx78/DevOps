# AWS

- Enables you to build sophisticated, scalable applications.
- Use cases = 
  - Gaming
  - Enterprise IT.
  - Backup + storage, big data analytics.
  - Website hosting etc 


## Global Infrastructure

### Regions
- A region = a cluster of data centres. 
- Choose region based on:
  - Compliance with data governance and legal requirements. Data never leaves a region without your explicit permission. 
  - Proximity - reduced latency.
  - Available services within a region.
  - Pricing - varies according to regions. 

### Availability Zones 
- AZ's.
- Each region has multiple availability zones. 
- Usually 3 - max 6. 
- They're isolated from eachother. Maintains high availability. 
- Connected to eachother with high bandwith, ultra-low latency network. 


### Edge locations
- Points of presence.
- 400 points of presence - edge locations and regional caches. 
- Content is delivered to end users with lower latency. 
  

## Global service
- IAM
- Route 53 (DNS)
- CloudFront (CDN)
- WAF


## Create a new user
- Not good practice to use root user for daily tasks. 
- Make sure to set up MFA on root user. 
- Create a new use:
  - IAM
  - Create new user
  - Add permissions to the user - attach directly option while creating.
  - Add administrator access role.

- Sign in using that user. Not root account. 