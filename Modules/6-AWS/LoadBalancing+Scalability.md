# Load Balancing and Scalability. 

## Vertical scaling = increased resources on the same servers. E.g. more CPU.
  - Usually a limit to how much you can vertically scale (hardware limit).
  - E.g. RDS, Elasticache, databases. 

## Horizontal scaling = 
  - elasticity - adding more servers. 
  - Common for web applications/modern systems.
  - Easily scales. 


## High availability = 
- Running application in multiple locations to ensure that if one part fails, another part can take over. 
- Goes hand in hand with horizontal scaling. 
- Running applications across atleast 3 AZs. 
- The goal of HA = survive data centre loss. 

backups, etc Making sure systems can still run if any issues/ services going down etc.

## Load Balancing
- Load balancer can distribute traffic over multiple AZs. 
- Forwards traffic to multiple servers. 
- = ELB = Elastic load balancer. 

- You can expose a single point of access (DNS) to your application. 
- Can seamlessly handle failures of downstream instances. 
- Does regular health checks to your instances. 
- Provide SSL termination (HTTPS) for your websites. 
- Enforce stickiness with cookies. 
- High availability across zones. 
- Separate public traffic from private. 

### ELB 

- Managed load balancer. 
- AWS guarantees that it will be working. 
- AWS takes care of upgrades, maintenance and HA. 
- It's integrated with a lot of AWS services. 
  - E.g. integrated with certificate manager to handle SSL certs. 

### Health checks:
  - The health check is done on a port and a route (/health is common)
  - If the response is not 200 (ok), the instance will be shown as unhealthy and traffic will be routed to other instances. 
  - Prevents downtime/disruption to users. 

### Types of load balancers:

- CLB = Classic 
  - Old generation. 
  - HTTP, HTTPS, TCP, SSL. 

- ALB - Application load balancers
  - HTTP, HTTPS, WebSocket.

- NLB - Network load balancer
  - TCP, TLS, UDP. 

- GWLB - Gateway load balancer
  - Operates at layer 3 - IP protocal 
  - Network layer. 

- Some load balancers can be set up as internal (private) or external (public) ELBs. 


### Load balancer security groups 
- Allow users to connect to load balancer from anywhere on the internet.
- E.g. port 80 and 443 from anywhere.
- The Application security group will only enable access from the load balancer. 


## Application Load Balancer
- Each load balancer gets a URL and the applications are accessed through the URLs. 
- Layer 7 - HTTP
- Load balancing to multiple applications on the same machine e.g. containers. 
- Load balancing to multiple HTTP applications across machines (targets).

- Target groups = servers you need to send the traffic to. 
- Routing based on path in URL. 
- Routing based on hostname in URL - Can run multiple domains in the same ALB. 
- Routing based on query string. 
- Great for microservices. E.g. containers, ECS, docker etc. 
- Has a port mapping feature to redirect to a dynamic port in ECS. 
- Can use different target groups for different sub services. 

- Target groups:
  - EC2 instances
  - ECS tasks
  - Lambda functions
  - IP addresses - must be private!
  - Can route to multiple target groups.
  - Health checks are at the target group level. 

### Fixed hostname:

- When you create an ALB, AWS gives it a web address (hostname),
- That name never changes for as long as the ALB exists.
- What does change is the ALB’s IP addresses. Behind the scenes, AWS adds, removes and replaces the machines running your load balancer as traffic goes up and down, and their IPs change with them.
- So the rule is: always point to the ALB by its hostname, never by an IP address. If you hard-coded an IP, it could stop working at any moment.
- In real jobs, you don’t give users that long ugly name either. You create a friendly one like www.myshop.com in Route 53 (AWS’s DNS service) and point it at the ALB’s hostname.



### Servers don’t see the client’s real IP

- The ALB doesn’t just pass traffic straight through. It actually has two separate connections:

    - The visitor connects to the ALB.
    - The ALB makes its own, new connection to your server.

- So from your server’s point of view, every request comes from the ALB. The IP it sees is the ALB’s private IP, not the visitor’s.

- This matters because servers often need the real IP, for things like:

    - Logs: knowing who visited.
    - Security: blocking a specific attacker, or limiting how often one person can make requests.
    - Location: showing content based on the visitor’s country.


### THE FIX: X-Forwarded headers:

- To solve the fact that the servers can't see the IP of the visitor, the ALB attaches a note to each request before passing it on. These notes are called headers (extra pieces of information sent along with every web request).

   -  X-Forwarded-For holds the visitor’s real IP address. Your app reads this instead of the connection IP.

   -  X-Forwarded-Port holds the port the visitor connected to on the ALB. Usually 443 (secure, HTTPS) or 80 (normal, HTTP).

   -  X-Forwarded-Proto holds the protocol the visitor used: http or https.

- Why Proto and Port matter: a common setup is that visitors connect to the ALB using secure HTTPS, but the ALB talks to your servers using plain HTTP inside AWS’s private network. Without this header, your app would think everyone is using insecure HTTP. With it, the app can tell, and for example redirect anyone who arrived on http over to https.

## Network Load Balancer
- FAST!
- Less latency.
- Layer 4. 
- Forward TCP and UDP traffic to your instances. 
- Handles millions of request per seconds. 

- NLB has one static IP per AZ and supports assigning elastic IP. 
- Not included in AWS free tier.


### NLB - TCP

- TCP (Layer 4) based traffic. 
- Layer 4 = transport layer.
- Routes real time TCP/UDP traffic to your instances. 
- Handles HTTP traffic too but doesn't handle headers etc. 


## Sticky Sessions 
- Enables stickiness so that the same client is always redirected to the same instance behind a load balancer. 
- Works for all load balancers except GWLB.
- For both CLB and ALB - the cookie used for stickiness has an expiration date you control. 
  - The cookie is what binds user to a session. 
  - Can choose how long the user stays stuck. 
- It makes sure the user doesn't lose his session data. 
- Enabling stickiness may bring imbalance to the load over the backend EC2 instances. 
  - E.g. if too many clients are stuck to it. 
  - Decreases performance. 
- Causes imbalance in load distribution. 


## SSL AND TLS

- TLS = modern version of SSL. 
- SSL = used to encrypt connections. 
- An SSL certificate allows traffic between your clients and your load balancer to be encrypted in transit. 
- TLS certificates are more used now, but people still refer to them as SSL certs. 
- Public SSL certs are issued by Certificate Authorities (CA).
- E.g. Digicert, GoDaddy, Cornodo, GlobalSign etc. 
- SSL certs have an expiration date you set and must be renewed. 


### Load balancers and SSL cert
- Middle man - makes sure traffic between servers and users is encrypted. 
- ACM - AWS certificate manager. 
- Can also upload old custom certificates. 
- HTTPS listener -  
  - Must specify a default certificate. 
  - Clients can use SNI to specify the hostname they reach. 
  - Ability to specify a security policy to support older versions of SSL/TLS.

### SSL - SNI (Server name indication)

- Before SNI, it was a headache. If you wanted to host multiple websites on the same server with different SSL certs, you needed to have multiple IPs. 
- But with SNI, you can load multiple SSL certificates onto one web server to serve multiple websites. 
- Client needs to indicate the hostname of the target server in the initial SSL handshake, and then the server will find the correct cert or return the default one. 
- Doesn't work for older gen load balancer (CLB).


- Application load balancer = 
  - Supports multiple listeners with multiple SSL certificates. 
  - Uses SNI to make it work.
  - Same with Network load balancer. 


## CONNECTION DRAINING - DE-REGISTRATION DELAY

- Connection draining = for CLB. 
- Degregistration delay = for ALB and NLB. 
- Inflight requests while the instance is deregistering or unhealthy in the load balancer. 
- It stops sending new requests to the instance (which is deregistering).
- But it waits for active requests to finish - 1 to 3600 seconds. 
- A feature to make sure users don't get interrupted. 
- Can be set to 0 or a low value. 


# Autoscaling

- Scale out to match an increased load. (Add EC2 instances)
- Scale in to match a decreased load. (remove EC2 instance)
- Ensure we have a minimum and maximum number of EC2 instances running. 
- Automatically register new instances to a load balancer. 
- Re-create an EC2 if a previous one is unhealthy/terminated. 
- ASG = FREE - only pay for underlying EC2.
- Uses AMI to launch new instances. 
- Can use Autoscaling with load balancers. 

## Attributes for autoscaling group

- AMI + Instance type
- EC2 User data
- EBS volumes
- Security groups
- SSH key pairs
- IAM roles for EC2 instances. 
- Network and subnets information.
- Load balancer information.
- Scaling policies.
- min size, max and initial capacity. 


## Cloudwatch alarms and scaling

- You can scale ASG based on cloudwatch alarms. 
- An alarm monitors a metric e.g. average CPU.
- Scale in and out policies. 

### Types of scaling policies:

- Target tracking scaling
  - E.g. Want the average CPU to stay at around 40%

- Step scaling/simple 
  - When a cloudwatch alarm is triggered e.g. CPU over 70% and then add 2 units. 

- Scheduled scaling
  - Based on known usage patterns. 
  - E.g. increase the capacity 10am to 5pm.


## Potential Interview questions:

1. When would you pick an NLB over an ALB?

- Both spread incoming traffic across your servers. The difference is how much they look at the traffic.

- ALB (Application Load Balancer) reads each request. It understands web traffic (HTTP/HTTPS), so it can make smart decisions:

  - Send /images to one group of servers and /checkout to another
  - Route by website name (shop.example.com vs blog.example.com)
  - Handle HTTPS certificates and work with a WAF (web firewall)

- NLB (Network Load Balancer) doesn’t read the request. It just passes the connection through, extremely fast:

  - Handles millions of requests per second with very low delay
  - Gives you a fixed IP address, which some customers need to add to their firewall allowlists
  - Works with non-web traffic, like online games, IoT devices, video streaming or databases (TCP/UDP)


- Interview answer:

“I’d use an ALB for web applications and microservices, because it works at Layer 7 and can route based on URL paths or hostnames. I’d pick an NLB when I need extreme performance and low latency, a static IP address, or non-HTTP traffic like TCP or UDP, for example gaming or IoT. The NLB works at Layer 4.”


“By default I’d use an ALB for web apps and APIs, because of path-based routing, HTTPS handling and WAF integration. I’d choose an NLB when there’s a specific requirement: static IPs for client allowlisting, exposing a service through PrivateLink, non-HTTP protocols like UDP for gaming or MQTT for IoT, extreme or sudden traffic spikes, or TLS passthrough for compliance. If I need static IPs and Layer 7 routing together, I’d put an NLB in front of an ALB.”


- An ALB’s IPs change over time, while an NLB can have fixed Elastic IPs.
- End-to-end encryption for compliance. Some regulated industries require that traffic stays encrypted all the way to the server. An ALB decrypts traffic to read it, while an NLB can pass it through still encrypted.

2. Why is connection draining critical during scaling?

- When auto scaling removes a server (scaling in), some users may be halfway through something on it, like loading a page, uploading a file or paying.

- Connection draining (AWS calls it deregistration delay) means the load balancer:

  - Stops sending new users to that server
  - Lets current users finish what they’re doing (for up to 300 seconds by default)
  - Then the server is removed

- Without it, the server disappears mid-request and those users get errors: failed payments, broken uploads, half-loaded pages.


- Interview answer:

“During scale-in, instances get removed regularly. Connection draining makes the load balancer stop sending new requests to an instance while letting in-flight requests complete before it’s terminated. Without it, users would see dropped connections and errors every time the group scales in. It’s also used when an instance is being taken out for deployments or because it’s unhealthy.”


3. Name two metrics you’d auto-scale on for a read-heavy API

- A read-heavy API is one where most requests are people fetching data (viewing products, loading profiles) rather than saving it. That usually means lots of small, quick requests.

- Metric 1: Request count per target (ALBRequestCountPerTarget)
  - How many requests each server is handling. This measures load directly: if each server can comfortably handle 1,000 requests a minute, scale out before that’s reached. It reacts to traffic increases quickly, often before CPU rises.

- Metric 2: Response time / latency (TargetResponseTime), or CPU utilisation
  - Latency shows what users actually experience. If responses are slowing down, you need more servers.
  - CPU is the classic choice: if servers are working too hard, add more.


- Interview answer:

“For a read-heavy API I’d scale on request count per target, because it measures load directly and reacts quickly to traffic spikes, and on target response time, because that reflects the user experience. CPU utilisation is also a solid choice. I’d also mention that for read-heavy workloads, adding a cache like ElastiCache or CloudFront, and database read replicas, often helps more than adding servers, because the bottleneck is usually the database.”



