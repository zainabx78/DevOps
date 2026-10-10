# Docker Networking

## Bridge Network

- Bridge network --> default network mode for containers on the same machine. 
  - Containers connected to the bridge network can communicate with eachother using their own IP addresses.
  - Isolated from host machine's network. Extra layer of security.


## Host Network 

- Container uses host machines's network without any isolation.
- Useful for applications that need to closely interact with the host network.


## None Networking mode

- No network interface at all.
- Container is completely isolated.
- Useful for security scenarios. 

