---
layout: post
title: "Cent OS 7 - temporarily disable ipv6"
categories:
---

In `/etc/sysctl.conf` add

``` ini
# ... other stuff ...
net.ipv6.conf.all.disable_ipv6 = 1
# or
# net.ipv6.conf.<NIC name>.disable_ipv6 = 1
```

then do

``` bash
sysctl -p
```
to reload settings.

To reenable ipv6 just comment it out (or set it to `0` maybe).
