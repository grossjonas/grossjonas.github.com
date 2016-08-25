---
layout: post
title: "Cent OS 7 - temporarily disable ipv6"
categories:
---

Recently I tried [Let's encrypt](https://letsencrypt.org/) with [lego](https://github.com/xenolf/lego) as client, since I had problems with the official one, but I could not determine what exactly went wrong.
With [lego](https://github.com/xenolf/lego) this was easy: `Connection timed out` ... but why?

Turns out I could not reach [Let's encrypt](https://letsencrypt.org/) via IPv6.

So here is how to disable it (temporarily):

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

To re-enable ipv6 just comment it out (or set it to `0` maybe).

## Update

[Let's encrypt](https://letsencrypt.org/) added IPv6 support, see [their blog post](https://letsencrypt.org/2016/07/26/full-ipv6-support.html)
