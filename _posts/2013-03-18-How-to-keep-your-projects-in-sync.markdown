---
layout: post
title:  "How to keep your projects in sync"
categories: subversion svn git bash sync
---

# Cluttered

What once started as hobby is now my job. I am a dev. So I work on projects. 

When I was new on that I stored my projects just where the IDE wanted me to store it ( like ~/workspace ). But soon this got cluttered - diffrent IDEs, diffrent VCSs, diffrent folders in diffrent paths and no clue where that one project is, you worked on half a year ago and now it needs an update.

Right now, all my projects are in *~/projects* and then ordered by the domain which holds the VCS repository. Luckily there are only *svn* und *git* repos. 

Keeping them in sync was no problem in the beginning, but over the years it got annoying because I had no _update all_ command, so I had to "cd" to the root of all depending repos, "Insert VCS update command here" these depending repos, "Insert same VCS update command here" the repo I wanted to work with. This does not sound like much but there is a point when too many repos need to be updated and you occassionally forget one and waste hours screwing around.

Putting together a script to update all git repos was easy, but when I tried to use _find_ (the swiss army knife of searching your stuff) to only call a command in the root folder of a repo I became desperate.

Like almost always [Google was my friend](http://www.giyf.com/). I found [Mathieu Carbou's script](http://blog.mycila.com/2009/07/recursive-svn-update.html) and was able to put together this  one:

{% highlight bash %}
#!/bin/bash

count=0
curDir=`pwd`
path="."

# Thank you, Mathieu Carbou
# http://blog.mycila.com/2009/07/recursive-svn-update.html

update ()
{
	#echo "Call to update ($1)"
	if [ -d $1/.svn ]
	then
		echo "Updating $1..."
		svn up $1
	else
		# echo `ls`
		for i in `ls $1`
		do
			if [ -d $1/$i ]
			then
			# echo "Descending to $i..."
				update $1/$i
			fi
		done
	fi
}
 
if [ "$1" == "" ]; then
	echo "Updating all SVN projects in ${curDir} ..."
else
	echo "Updating all SVN projects in $1..."
	path=$1
fi

update ${path}

for i in `find ${path} -iname ".git"`
do
	cd `dirname ${i}`
	git pull
	cd ${curDir}
done
{% endhighlight %}

Just 

{% highlight bash %}
chmod +x <script>
{% endhighlight %}

this and live happily ever after :)

