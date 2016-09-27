---
layout: post
title: raspberry pie notes
---

# [ArchLinux on the Pie](https://archlinuxarm.org/)
* [Raspberry Pie (B)](https://archlinuxarm.org/platforms/armv6/raspberry-pi)
* [Raspberry Pie 3](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3)


# Remount writable:
``` bash
mount -o remount,rw /
```

# Mount usb disk:
``` bash
udisksctl status
# see column "Device", e. g. for "sda" you do
udisksctl mount -b /dev/sda1
```
