# ROUTING

- Process of determining paths for data to travel across networks.
- Ensures data reaches it's destination efficiently. 
- Fundamental for internet functionality.

## How Routing Works?

- Routers determine the best path.
- Use routing tables to make decisions.

```

Computer 1 --> Router --> Network (1-4) --> Computer 2

```

- A good route = reduction in latency = network performance optimization.
- Ensures reliable application delivery.
- Crucial for managing complex infrastructure.


## Static Routing
- Routes are manually set up by network admins.
- E.g. giving data a fixed map to follow.
- Updates are manual.
- simple but not scalable.

## Dynamic Routing
- Routers are automatically 
- Uses algorithms to automatically find the best path for data.
- If route is changed, it re-routes data automatically. 
- Scalable and adaptable.


## Routing Protocols
- Automate route determination.
- Enhance network efficiency.
- Makes sure data takes the fastest route.
- Use algorithms to figure out the best paths.
- Automatic route updates!

### OSPF
- Open Shortest Path First
- Finds the shortest path for data to follow.
- Large organisations.
- Considers the status of a network.
- Uses Link-State information to make routing decisions.
- Quickly recalculates routes when there's changes in the network.
- FAST
- OSPF is used inside one organisation, like a university, a hospital or a big company

### BGP
- Border Gateway Protocol
- Used to route data between different autonomous systems (large networks managed by single organizations).
- Uses path vector mechanism --> manitains the path formation that gets updated dynamically as the network topology changes.
- Allows network admins to define routing policies based on various attributes.
- BGP is used between organisations. It’s the protocol that holds the whole internet together.


OSPF works inside one organisation’s network, and BGP works between different organisations’ networks.