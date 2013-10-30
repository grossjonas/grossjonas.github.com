---
layout: post
title:  "Flylatex - up, up in the sky ..."
categories: latex bash unix
---

# FLYLATEX - who, where and what???

A few weeks ago I registered to [sharelatex](https://www.sharelatex.com/) in the hope to get an office in the cloud with the best type setting that is available. 

The idea is really nice but it always feels kind of wrong giving your data to someone else. So when I read about Daniel Alabis release of flylatex at Hacker News, I instantly forked it :) 

## Prerequisites
All you need to run flylatex is descriped at the [github site](https://github.com/alabid/flylatex) - in a README.md. The basic requirements are

* [nodejs](http://nodejs.org/)
* npm(comes with nodejs usually ...)
* [mongodb](http://www.mongodb.org/)

So fire up that Ubuntu 12.04.2 LTS and go.

{% highlight bash %}
apt-cache search nodejs
apt-cache showpkg nodejs
{% endhighlight %}

STOP - this version is from the stone age or something. So let\'s ask my [friend](http://www.giyf.com/).

Jepp, [this ppa](https://launchpad.net/~chris-lea/+archive/node.js/) is what I wanted.

So there it goes:

{% highlight bash %}
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
nodejs -v // v0.10.0 - okay
npm -v // 1.2.14 - kk, too
apt-cache search mongodb
apt-cache showpkg mongodb // 2.0.4 - damn that 0.4 releases behind right now ... *arg* never mind
sudo apt-get install mongodb
{% endhighlight %}

Okay, that runs a mongodb right after installing ... hmm ... let's have a look:

{% highlight bash %}
cd /etc/init
ls -al | grep mongo // mongodb.conf
{% endhighlight %}

So it's an [upstart job](http://upstart.ubuntu.com/). That's okay for a server, but this time I sit in front of my laptop and just want to fiddle about it a bit _before_ deploying it to my server. So:

{% highlight bash %}
sudo vim /etc/init/mongodb.conf
:%s/start\ on/#start\ on/gc
:x
{% endhighlight %}

Now we should be ready.

Almost - I forgot a slightly important part. I already had done:
{% highlight bash %}
sudo apt-get install texlive-full
{% endhighlight %}

(Attention: this download a few gigs of binaries and installs them after that - this could be a looong procedure.)

## First start

So now it\'s time to check out:
{% highlight bash %}
git clone https://github.com/alabid/flylatex.git
cd flylatex
{% endhighlight %}

Grep all dependencies:

{% highlight bash %}
npm install -d
{% endhighlight %}

Customize configuration:

{% highlight bash %}
vim configs.js
{% endhighlight %}

... I just commented out *path: ...* (:%s/path\:/\/\/path:/gc)

And now _drum roll_:

{% highlight bash %}
nodejs app.js
{% endhighlight %}

Ah the output points us to:

{% highlight bash %}
lynx localhost:3000
{% endhighlight %}

Just kiddin'. It seems to work with lynx but I recommend using a full blown graphical browser like luakit or uzbl and just have fun!

## The end - an afterword

From now on you must remember to

{% highlight bash %}
sudo service mongodb start
{% endhighlight %}

before 

{% highlight bash %}
cd <my flylatex dir>
nodejs app.js
{% endhighlight %}


## HF :D

