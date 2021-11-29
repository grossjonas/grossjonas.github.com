---
layout: post
title: Basic haiku setup
---

Recently I had a lot of fun exploring [haiku os|https://www.haiku-os.org/].
In fact so much fun that I wanted to write about it ... even that long of a pause.

# basics

ToDo: text here!

## spacevim

ToDo: text here!

``` bash
cd $HOME
curl -sLf https://spacevim.org/install.sh | bash
mv .vim config/setting/vim
mkdir /system/non-packaged/data/fonts/ttfonts
mv .local/share/fonts/* /system/non-packaged/data/fonts/ttfonts/
```

## git

ToDo: text here!

``` bash
cd /boot/home/config/settings/ssh
cd /boot/home/config/settings/ssh> ssh-keygen -o -a 100 -t ed25519 -f github
cd /boot/home/config/settings/ssh> cat github.pub
ssh-ed25519 ABC<not some many letters>abc user@shredder
cd /boot/home/config/settings/ssh> tail config
Host github.com
    IdentityFile ~/config/settings/ssh/github
```

