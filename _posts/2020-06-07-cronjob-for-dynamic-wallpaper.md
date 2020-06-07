---
layout: post
title: cronjob for dynamic wallpaper
date: 2020-06-07 17:18 +0200
---
Recently I stumbled across [adi1090x's nice dynamic wallpaper project](https://github.com/adi1090x/dynamic-wallpaper).
In order to get it working as a cronjob I encountered a few notable issues:

* cron jobs run with a very restricted shell (which is good)
* in order to let `feh` (or any other program) change your background ... it needs to know what background

It could have been this short ride ... but I took a nice long stroll through *nix programms to end up with
 
``` bash
env | grep DISPLAY
# remember the value
# look up cron ... not quartz syntax
# start editing the user cron  
  crontab -e
```
and insert this line

``` 
*/5 * * * * DISPLAY=:0.0 dwall -o firewatch >> /tmp/dwallwrapper.log
```

This checks for the right wallpaper every 5 minutes.
So sit back and enjoy.