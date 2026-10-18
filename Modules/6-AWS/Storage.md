# STORAGE

## EBS Volume
- Elastic Block Store = a network drive you can attach to your instances while they run. 
- It allows your instances to persist data, even after termination. 
- They are bound to a specific AZ.
- E.g. a network USB stick.


## EFS
- Elastic File System
- Managed NFS (network file system) that can be mounted on many EC2. 
- EFS works with EC2 instances in multi-AZ.
- Highly available, scalable and expensive. 
- Can mount the same data on different servers. 