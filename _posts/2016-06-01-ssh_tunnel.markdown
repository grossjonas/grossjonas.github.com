---
layout: post
title: "SSH tunnel"
categories: ssh
---

I constanty mess the order of ports up and need to look it up almost every time. But all I want to know is:
``` bash
ssh -L <local port>:<remote ip or dns>:<remote port> -l <user> -p <port> <host>
```

I always mess up ports placement. So if I want to connect to my syncthing web-ui and that ui runs on `127.0.0.1:8384` on the remote machine, i might use something like
``` bash
ssh -L 9394:127.0.0.1:8384 -l me -p 1234 mysyncthingbox.com
```
