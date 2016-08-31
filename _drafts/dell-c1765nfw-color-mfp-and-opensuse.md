---
layout: post
title: Dell C1765nfw Color MFP and OpenSuse
---
A while ago I bought a Dell C1765nfw Color MFP.
The feature set was exactly what I wanted.

But there was something missing ... linux driver support.

Thank you, Mister Ralph Richardson, for making this awesome driver and releasing it [on your site](http://foo2hbpl.rkkda.com/).

Since the C1765nfw would be nothing more than a brick for me without your driver I gladly donated a few dollars.

Since I could not find any license I assume it's okay to host a copy [here](/assets/files/foo2zjs.tar.gz).

Installation was easy on my OpenSuse system ... so just for short reference:

``` bash
wget -O foo2zjs.tar.gz http://foo2zjs.rkkda.com/foo2zjs.tar.gz
tar zxf foo2zjs.tar.gz
cd foo2zjs
make
sudo make install
sudo reboot # since `make cups didn't work for me`
```

After that I could graphically "install" the printer by using auto detect and selecting "Dell C1765 Foomatic/foo2hbpl2 (recommended)" as driver.
