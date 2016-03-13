---
layout: post
title:  "Stop mysql & apache from starting automatically"
categories: mysql apache upstart 
---

# Diffrent worlds

The XAMPP is quite convenient. It provides everything you need to quickly develop a simple website. But sometime you want the full package to enable mods like mod_userdir and such a like whitout running apache & mysql on bootup on your private part time development laptop for example.

It is really simple to install those packages and only activate them on demand.

To do so you obviously need to install ( or have them installed already ) and know how the get started. On my Ubuntu 12.04 these packages use diffrent methods for autostarting.

While *apache* is still started by an init-script, *mysql* is already an upstart job.

## Install

Just a quick remark: I recommend installing *mysql-workbench* also.
So:

``` bash
sudo apt-get install mysql-server mysql-client mysql-workbench
sudo apt-get install apache2
```

## Deactivate autostart 

Now it is time to deactivate them both.

### apache aka init

*apache* gets started via an [init-script](http://en.wikipedia.org/wiki/Init) on Ubuntu 12.04.2 LTS ( `cat /etc/issue` ). These script can be managed by *update-rc.d*, so the manpage is a good start for more information. To fully understand that manpage you also need to know the diffrent run-levels and their purpose, which will lead you to the [Linux Standard Base specification](http://en.wikipedia.org/wiki/Runlevel). Finally it is obvious: Just disabling auto startup is the only reasonable way to go, since maybe autostart is need some day in future ...
So:

``` bash
sudo update-rc.d -f apache2 disable
```

### mysql aka upstart

*mysql* is invoked by [upstart](http://en.wikipedia.org/wiki/Upstart). This is Ubuntu's 'own' startup mechanism. [This](http://upstart.ubuntu.com/getting-started.html) is where you can get the basics.
To make a long story short:

``` bash
sudo vim /etc/init/mysql.conf
:% s/start\ on\ runlevel/#start\ on\ runlevel/gc
```


### Restart ...
... and see if it works

``` bash
ps aux | grep mysql
ps aux | grep apache
```

