---
layout: post
title:  "unix rename for Mac OS X"
categories: unix linux macosx
---

Most of the time I am using Linux – at work, on my pc-tower, … . The longer you use CLI the more you see it’s advantages. You learn stuff once and use it everywhere – POSIX compliance rocks. But there was one thing missing. A small addition to the POSIX-standard which is available on almost every Linux-system.

I’m talking about the ‘rename’-command which works like that:
{% highlight bash %}
$ rename <RegEx> <file or list of files>
{% endhighlight %}

But building your own rename-command on Mac is quite easy and you can do it with tools that are already on your system. So just write this little bash-script:

{% highlight bash %}
#!/bin/bash

REGEX=$1

shift

for i in $@; mv $i `echo “$i” | sed $REGEX`;done
{% endhighlight %}

Name it “rename” and make it executable.

{% highlight bash %}
$ chmod +x rename
{% endhighlight %}

And finally move it to the right spot.

{% highlight bash %}
$ mv rename /bin/
{% endhighlight %}
 
Et voila. My favorite command works again.

{% highlight bash %}
$ rename ‘s/\ /\_/g’ This\ lousy\ filename\ contains\ too\ many\ spaces.txt
{% endhighlight %}

