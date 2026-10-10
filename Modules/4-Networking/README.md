# 4 - Networking

Notes and hands-on practice for how computers connect and communicate across networks.

## Contents

| # | Topic | What it covers |
|---|-------|----------------|
| 1 | [Networking Intro](Intro.md) | What a network is and the key terms to know |
| 2 | [OSI Model](OSI-Model.md) | The 7 layers that explain how data moves across a network |
| 3 | [Subnetting](Subnetting.md) | IP addresses, CIDR notation and splitting networks into smaller parts |
| 4 | [Routing](Routing.md) | How routers decide where to send traffic |
| 5 | [DNS](DNS.md) | How domain names are turned into IP addresses |
| 6 | [Debugging and Troubleshooting](Debugging+Troubleshooting.md) | Tools and steps for finding and fixing network problems |
| 7 | [DNS Project](<PROJECT - DNS+EC2.md>) | Hands-on project putting the module into practice |

## Key Takeaways

- Use the OSI Model to narrow down where a problem is happening.
- The bigger the number after the `/` in CIDR, the smaller the network.
- Routers pass traffic step by step using routing tables and a default gateway.
- If a site works by IP but not by name, it's a DNS problem.
- Troubleshoot from the bottom up with `ping`, `traceroute`, `nslookup` and `dig`.

[⬅ Back to main page](../../README.md)
