---
layout: post
title:  "Get version of OS"
categories: OS unix linux macosx 
---

Where am I?
===========

If it's at work or at home, people like us most often have more than just one computer. These might just stand next to you or in an other room and you want that one pc to handle this one task you need to procede.
No problem just install a piece of software and you set ... nope, doesn't work like that.

Often enough you can't reach those machine because they are in a subsidary 100 miles away or you are just too lazy to walk up there to check whether it's the right OS and version of that OS.

But hey that's no problem. Everything is wired up, so grab that console and connect over there. 
But where did you land?

Let's have a quick check. Should also be no problem. That [POSIX-Standard](http://en.wikipedia.org/wiki/Posix) from the 80ies will do. Just have a quick look and yep, there is some handy [programm for that](http://pubs.opengroup.org/onlinepubs/9699919799/). So:

{% highlight bash %}
uname -s
{% endhighlight %}

Wow, that really doesn't help. So let's look at all information:

{% highlight bash %}
uname -a
{% endhighlight %}

and get an output like:

{% highlight bash %}
Linux hXXXXXX.myserver.net 2.6.32-028stab091.2 #1 SMP Fri Jun 3 00:02:40 MSD 2011 i686 GNU/Linux
{% endhighlight %}
{% highlight bash %}
Darwin myBook-2.local 10.8.0 Darwin Kernel Version 10.8.0: Tue Jun 7 16:33:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386 i386
{% endhighlight %}

<irony>Jeah - now I know that my time is set wrong ...</irony>

Wikipedia has a nice list of uname-output [here](http://en.wikipedia.org/wiki/Uname), but these cryptic numbers don't really help. On \*nix-system you can often find usefully information with:

{% highlight bash %}
cat /etc/issue
# Just for example
# ================
# Debian GNU/Linux 6.0 \n \l
#
# CentOS release 6.4 (Final)
# Kernel \r on an \m
#
# Ubuntu 12.04.2 LTS \n \l
{% endhighlight %}

That one is easy to remember, but for Macs I always end up googling. So this snippet is for *drum roll* :

{% highlight bash %}
system_profiler SPSoftwareDataType
{% endhighlight %}

Jepp, almost as easy to remember as the previous line ... ;)

There are a few other tipps and tweaks to get the OS-Version like:

{% highlight bash %}
lsb_release -a
cat /proc/version
cat /etc/issue.net
{% endhighlight %}

and others. So have fun exploring and bye bye.
